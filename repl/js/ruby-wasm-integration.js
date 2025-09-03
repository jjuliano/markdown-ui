// Ruby WebAssembly Integration for MarkdownUI REPL
// Based on ruby.wasm documentation

class RubyWasmIntegration {
  constructor() {
    this.vm = null;
    this.isInitialized = false;
    this.executionMode = 'cdn';
  }

  async initialize() {
    try {
      console.log('🔧 Initializing Ruby WebAssembly VM...');
      console.log('📥 Loading WebAssembly module...');
      
      // Load the Ruby WebAssembly module from CDN
      const { DefaultRubyVM } = await import('https://cdn.jsdelivr.net/npm/@ruby/wasm-wasi@2.7.1/dist/browser/+esm');
      
      // Try to load our custom-built WASM with markdown-ui gem first
      try {
        console.log('🔍 Trying to load custom WASM with markdown-ui gem...');
        const customResponse = await fetch(`markdown-ui.wasm?v=${Date.now()}`);
        console.log('📄 Custom WASM response status:', customResponse.status, customResponse.statusText);
        
        if (customResponse.ok) {
          console.log('📦 Custom WASM response headers:', {
            'content-type': customResponse.headers.get('content-type'),
            'content-length': customResponse.headers.get('content-length')
          });
          
          const customModule = await WebAssembly.compileStreaming(customResponse);
          console.log('✅ Loaded custom WebAssembly module with markdown-ui: ' + (customResponse.headers.get('content-length') || 'unknown size') + ' bytes');
          
          console.log('🔧 Initializing Ruby VM with custom bundle...');
          console.log('📚 Loading Ruby stdlib + markdown-ui gem...');
          
          // Initialize the Ruby VM using our custom module
          console.log('🚀 Creating Ruby VM instance...');
          const { vm } = await DefaultRubyVM(customModule);
          this.vm = vm;
          this.executionMode = 'custom-wasm';
          
          console.log('✅ Ruby VM created successfully with custom bundle');
          
          this.isInitialized = true;
          
          // Set up the parser after VM is ready
          await this.setupParser();
          
          return true;
        } else {
          throw new Error(`Custom WASM responded with ${customResponse.status}: ${customResponse.statusText}`);
        }
      } catch (customError) {
        console.log('⚠️  Custom WASM loading failed:', customError.message);
        console.log('📝 Error details:', customError);
        console.log('⚠️  Custom WASM not available, falling back to CDN version');
        console.log('Run `npm run build` to create the custom WASM bundle with markdown-ui');
        
        // Fallback to CDN version (won't have markdown-ui gem)
        const response = await fetch('https://cdn.jsdelivr.net/npm/@ruby/3.4-wasm-wasi@2.7.1/dist/ruby+stdlib.wasm');
        const module = await WebAssembly.compileStreaming(response);
        
        console.log('✅ Loaded WebAssembly module: ' + (response.headers.get('content-length') || '67604955') + ' bytes');
        console.log('⚠️  Note: This CDN version does not include the markdown-ui gem');
        
        console.log('🔧 Initializing Ruby VM...');
        console.log('📚 Loading Ruby stdlib...');
        
        // Initialize the Ruby VM using the exact pattern from documentation
        console.log('🚀 Creating Ruby VM instance...');
        const { vm } = await DefaultRubyVM(module);
        this.vm = vm;
        this.executionMode = 'cdn-fallback';
        
        console.log('✅ Ruby VM created successfully');
        
        this.isInitialized = true;
        
        // Set up the parser after VM is ready (will likely fail without custom build)
        try {
          await this.setupParser();
        } catch (setupError) {
          console.error('❌ Parser setup failed as expected (markdown-ui gem not available in CDN version)');
          console.log('💡 To fix this: Run `npm run build` to create custom WASM bundle');
          throw setupError;
        }
        
        return true;
      }
    } catch (error) {
      console.error('❌ Failed to initialize Ruby WebAssembly:', error);
      console.error('Error details:', error.message);
      throw error;
    }
  }

  async setupParser() {
    console.log('🔧 Setting up MarkdownUI parser...');

    // Execute REAL Ruby code in WebAssembly to set up the parser
    this.vm.eval(`
      require "bundler/setup"
      require "markdown-ui"

      $parser = MarkdownUI.new(beautify: true)

          def parse_markdown(markdown)
            begin
              result = $parser.parse(markdown)
              puts "Parsed markdown successfully (#{result.length} chars)"
              result
            rescue => e
              puts "Error parsing markdown: #{e.message}"
              "# Error: #{e.message}"
            end
          end

      puts "Real MarkdownUI parser ready in WebAssembly"
    `);

    console.log('✅ Real MarkdownUI parser set up in Ruby WebAssembly');
  }

  async parseMarkdown(markdown) {
    if (!this.isInitialized) {
      throw new Error('❌ Ruby WebAssembly not initialized');
    }

    if (!this.vm) {
      throw new Error('❌ Ruby VM not available');
    }

    try {
      console.log('🔧 Parsing markdown with REAL Ruby WebAssembly...');

      // Call the REAL Ruby parse_markdown function running in WebAssembly
      const result = this.vm.eval(`parse_markdown(${JSON.stringify(markdown)})`);

      console.log('✅ Markdown parsing completed with real Ruby parser');
      return result.toString();

    } catch (error) {
      console.error('❌ Markdown parsing failed:', error);
      throw error;
    }
  }

  getStatus() {
    return {
      initialized: this.isInitialized,
      hasVM: !!this.vm,
      wasmAvailable: typeof WebAssembly !== 'undefined',
      method: this.executionMode || 'cdn-fallback'
    };
  }
}

// Export for use in other modules
window.RubyWasmIntegration = RubyWasmIntegration;