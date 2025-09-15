// Ruby WebAssembly Integration for MarkdownUI REPL
// Based on ruby.wasm documentation

class RubyWasmIntegration {
  constructor() {
    this.vm = null;
    this.isInitialized = false;
    this.executionMode = 'cdn';
    this.retryCount = 0;
    this.maxRetries = 3;
    this.reloadInProgress = false;
    this.lastErrorTime = 0;
    this.circuitBreakerDelay = 5000; // 5 seconds
    this.consecutiveErrors = 0;
    this.maxConsecutiveErrors = 5;
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

      $parser = MarkdownUI::Parser.new

          def parse_markdown(markdown)
            begin
              result = $parser.render(markdown)
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

    // Check circuit breaker
    if (this.isCircuitBreakerOpen()) {
      throw new Error(`❌ Circuit breaker open - too many consecutive errors. Wait ${Math.ceil((this.lastErrorTime + this.circuitBreakerDelay - Date.now()) / 1000)}s`);
    }

    try {
      console.log('🔧 Parsing markdown with REAL Ruby WebAssembly...');

      // Call the REAL Ruby parse_markdown function running in WebAssembly
      const result = this.vm.eval(`parse_markdown(${JSON.stringify(markdown)})`);

      console.log('✅ Markdown parsing completed with real Ruby parser');
      // Reset counters on successful parse
      this.retryCount = 0;
      this.consecutiveErrors = 0;
      return result.toString();

    } catch (error) {
      console.error('❌ Markdown parsing failed:', error);
      this.consecutiveErrors++;
      this.lastErrorTime = Date.now();

      // Check if this is a critical error that suggests WASM corruption
      if (this.isCriticalError(error)) {
        console.log('🔄 Critical WASM error detected, attempting automatic reload...');
        await this.handleCriticalError(markdown);
        return await this.parseMarkdown(markdown);
      }

      throw error;
    }
  }

  isCircuitBreakerOpen() {
    if (this.consecutiveErrors >= this.maxConsecutiveErrors) {
      const timeSinceLastError = Date.now() - this.lastErrorTime;
      return timeSinceLastError < this.circuitBreakerDelay;
    }
    return false;
  }

  isCriticalError(error) {
    const criticalPatterns = [
      'Unreachable code should not be executed',
      'RuntimeError: Unreachable code',
      'work_bufs',
      'BUFFER_BLOCK',
      'Crashed while printing bug report',
      'Assertion failed'
    ];

    const errorMessage = error.message || error.toString();
    return criticalPatterns.some(pattern => errorMessage.includes(pattern));
  }

  async handleCriticalError(markdown) {
    if (this.reloadInProgress) {
      console.log('⏳ WASM reload already in progress, waiting...');
      return;
    }

    if (this.retryCount >= this.maxRetries) {
      console.error(`❌ Maximum retry attempts (${this.maxRetries}) reached`);
      throw new Error(`WASM reload failed after ${this.maxRetries} attempts`);
    }

    this.reloadInProgress = true;
    this.retryCount++;

    try {
      console.log(`🔄 Attempting WASM reload (attempt ${this.retryCount}/${this.maxRetries})...`);

      // Reset VM state
      this.vm = null;
      this.isInitialized = false;

      // Wait a brief moment for cleanup
      await new Promise(resolve => setTimeout(resolve, 1000));

      // Reinitialize
      await this.initialize();

      console.log('✅ WASM successfully reloaded');

    } catch (reloadError) {
      console.error('❌ WASM reload failed:', reloadError);
      throw new Error(`WASM reload failed: ${reloadError.message}`);
    } finally {
      this.reloadInProgress = false;
    }
  }

  resetErrorState() {
    this.retryCount = 0;
    this.reloadInProgress = false;
    this.consecutiveErrors = 0;
    this.lastErrorTime = 0;
  }

  async forceReload() {
    console.log('🔄 Manual WASM reload requested...');
    this.resetErrorState();
    this.vm = null;
    this.isInitialized = false;

    await new Promise(resolve => setTimeout(resolve, 500));
    await this.initialize();
    console.log('✅ Manual WASM reload completed');
  }

  getStatus() {
    return {
      initialized: this.isInitialized,
      hasVM: !!this.vm,
      wasmAvailable: typeof WebAssembly !== 'undefined',
      method: this.executionMode || 'cdn-fallback',
      retryCount: this.retryCount,
      maxRetries: this.maxRetries,
      reloadInProgress: this.reloadInProgress,
      consecutiveErrors: this.consecutiveErrors,
      maxConsecutiveErrors: this.maxConsecutiveErrors,
      circuitBreakerOpen: this.isCircuitBreakerOpen(),
      lastErrorTime: this.lastErrorTime
    };
  }
}

// Export for use in other modules
window.RubyWasmIntegration = RubyWasmIntegration;