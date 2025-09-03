// MarkdownUI REPL Interface

class MarkdownUIREPL {
  constructor() {
    this.editor = null;
    this.rubyWasm = new window.RubyWasmIntegration();
    this.currentMarkdown = '';
    this.isRunning = false;
    this.syntaxMode = 'shorthand'; // 'shorthand' or 'blockquote'
  }

  async init() {
    console.log('Initializing MarkdownUI REPL...');

    try {
      // Initialize Monaco Editor
      await this.initializeEditor();

      // Initialize Ruby WebAssembly (required)
      const wasmSuccess = await this.initializeRubyWasm();

      if (!wasmSuccess) {
        console.error('WebAssembly initialization failed - MarkdownUI REPL requires WebAssembly');
        this.showWebAssemblyRequired();
        return;
      }

      // Set up event listeners
      this.setupEventListeners();

      // Set up syntax toggle
      this.setupSyntaxToggle();

      // Load example content
      this.loadExample();

      console.log('MarkdownUI REPL initialized successfully');
    } catch (error) {
      console.error('Failed to initialize REPL:', error);
      this.showWebAssemblyRequired();
    }
  }

  async initializeEditor() {
    console.log('Initializing Monaco Editor...');

    return new Promise((resolve, reject) => {
      // Check if Monaco loader is available
      if (typeof window.require === 'undefined') {
        console.warn('Monaco loader not available, falling back to textarea');
        this.fallbackToTextarea();
        resolve();
        return;
      }

      // Configure Monaco Loader
      window.require.config({
        paths: {
          'vs': 'https://unpkg.com/monaco-editor@0.45.0/min/vs'
        },
        waitSeconds: 30
      });

      window.require(['vs/editor/editor.main'], () => {
        try {
        // Create the editor
        this.editor = monaco.editor.create(document.getElementById('editor-container'), {
          value: '',
          language: 'markdown',
          theme: 'vs-light',
          fontSize: 14,
          minimap: { enabled: false },
          scrollBeyondLastLine: false,
          wordWrap: 'on',
          automaticLayout: true,
          tabSize: 2,
          insertSpaces: true,
          readOnly: false
        });

        // Listen for content changes
        this.editor.onDidChangeModelContent(() => {
          if (!this.isRunning) {
            this.debouncedParse();
          }
        });

          resolve();
        } catch (error) {
          console.error('Failed to create Monaco editor:', error);
          this.fallbackToTextarea();
          resolve();
        }
      }, (error) => {
        console.error('Failed to load Monaco editor:', error);
        this.fallbackToTextarea();
        resolve();
      });
    });
  }

  fallbackToTextarea() {
    console.log('Falling back to textarea editor...');

    const container = document.getElementById('editor-container');
    if (!container) {
      console.error('Editor container not found');
      return;
    }

    // Create a simple textarea
    const textarea = document.createElement('textarea');
    textarea.id = 'fallback-editor';
    textarea.style.width = '100%';
    textarea.style.height = '500px';
    textarea.style.fontFamily = 'monospace';
    textarea.style.fontSize = '14px';
    textarea.style.padding = '10px';
    textarea.style.border = '1px solid #ddd';
    textarea.style.borderRadius = '4px';
    textarea.style.resize = 'vertical';
    textarea.placeholder = 'Welcome to MarkdownUI Online REPL\n\nThis is a fallback textarea editor.\n\n## Features\n- Monaco Editor failed to load\n- Basic editing still works\n- Live preview is available';

    // Add change listener
    textarea.addEventListener('input', () => {
      if (!this.isRunning) {
        this.debouncedParse();
      }
    });

    // Replace container content
    container.innerHTML = '';
    container.appendChild(textarea);

    // Set up textarea-specific methods
    this.editor = {
      getValue: () => textarea.value,
      setValue: (value) => { textarea.value = value; },
      focus: () => textarea.focus(),
      onDidChangeModelContent: (callback) => {
        textarea.addEventListener('input', callback);
      }
    };

    console.log('Textarea fallback editor created');
  }

  showWebAssemblyRequired() {
    console.log('Showing WebAssembly required message...');

    // Show error message in the preview area
    const previewContainer = document.getElementById('preview-container');
    if (previewContainer) {
      previewContainer.innerHTML = `
        <div class="ui error message">
          <div class="header">WebAssembly Required</div>
          <p>The MarkdownUI Online REPL requires Ruby WebAssembly to function properly.</p>
          <p>Please ensure your browser supports WebAssembly and SharedArrayBuffer.</p>
          <div class="ui list">
            <div class="item">✅ Chrome 85+</div>
            <div class="item">✅ Firefox 78+</div>
            <div class="item">✅ Safari 14+</div>
            <div class="item">✅ Edge 85+</div>
          </div>
        </div>
      `;
    }

    // Disable the run button
    const runBtn = document.getElementById('run-btn');
    if (runBtn) {
      runBtn.disabled = true;
      runBtn.innerHTML = '<i class="exclamation triangle icon"></i> WebAssembly Required';
    }

    this.updateStatus('WebAssembly initialization failed', 'status-error');
    this.updateWasmStatus('Not available', 'status-error');
  }




  async initializeRubyWasm() {
    try {
      await this.rubyWasm.initialize();

      this.updateStatus('Ready', 'status-ready');
      this.updateWasmStatus('Loaded', 'status-ready');
      return true;
    } catch (error) {
      console.error('Ruby WebAssembly initialization failed:', error);
      this.updateStatus('WebAssembly failed', 'status-error');
      this.updateWasmStatus('Failed', 'status-error');
      return false;
    }
  }

  setupEventListeners() {
    // Run button
    document.getElementById('run-btn').addEventListener('click', () => {
      this.runCode();
    });

    // Export button
    document.getElementById('export-btn').addEventListener('click', () => {
      this.exportCode();
    });

    // Share button
    document.getElementById('share-btn').addEventListener('click', () => {
      this.shareCode();
    });

    // Element browser
    this.setupElementBrowser();

    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
        e.preventDefault();
        this.runCode();
      }
    });
  }

  setupElementBrowser() {
    // Make elements clickable
    document.querySelectorAll('[data-element]').forEach(element => {
      element.addEventListener('click', () => {
        const elementName = element.dataset.element;
        this.insertElement(elementName);
      });
    });

    // Initialize Semantic UI accordion
    $('.ui.accordion').accordion();
  }

  setupSyntaxToggle() {
    const toggle = document.getElementById('syntax-mode');
    const label = document.getElementById('syntax-label');

    if (toggle && label) {
      // Initialize Semantic UI checkbox
      $('.ui.checkbox').checkbox();

      // Set initial state
      toggle.checked = this.syntaxMode === 'blockquote';
      label.textContent = this.syntaxMode === 'shorthand' ? 'Shorthand' : 'Blockquote';

      // Add event listener
      toggle.addEventListener('change', (e) => {
        this.syntaxMode = e.target.checked ? 'blockquote' : 'shorthand';
        label.textContent = this.syntaxMode === 'shorthand' ? 'Shorthand' : 'Blockquote';
        console.log('Syntax mode changed to:', this.syntaxMode);

        // Update the default example to show current syntax
        this.loadExample();
      });
    }
  }

  insertElement(elementName) {
    const elementExamples = {
      button: '__Primary Button|Click Me__\n\n__Secondary Button|Another Action|secondary__\n\n__Button|Disabled|disabled__\n\n__Large Button|Big Action|large__\n\n__Icon Button|Icon:Cloud__\n\n__Labeled Icon Button|Icon:Pause, Pause__\n\n__Animated Button|Text:Next;Icon:Right Arrow__',
      header: '__Large Header|Welcome to MarkdownUI__\n\n__Medium Header|Section Title__\n\n__Small Header|Subtitle__\n\n__Dividing Header|Section Divider|dividing__',
      message: '__Success Message|Everything worked perfectly!__\n\n__Warning Message|Please be careful|warning__\n\n__Error Message|Something went wrong|error__\n\n__Info Message|Here is some information|info__\n\n__Message|Header:Changes in Service,Text:"We just updated our privacy policy here to better service our customers."__',
      segment: '__Segment|This is a basic content segment.__\n\n__Raised Segment|This segment is raised.|raised__\n\n__Secondary Segment|This is secondary content.|secondary__\n\n__Compact Segment|Compact content.|compact__',
      icon: '__Icon|user__\n\n__Icon|home__\n\n__Icon|search__\n\n__Icon|settings__',
      flag: '_PH Flag_\n\n_France Flag_\n\n_Netherlands Flag_\n\n_US Flag_\n\n_UK Flag_\n\n_Germany Flag_',
      image: '__Image|https://via.placeholder.com/300x200/000/fff__\n\n__Small Image|https://via.placeholder.com/100x100/000/fff__\n\n__Large Image|https://via.placeholder.com/500x300/000/fff__',
      label: '__Label|New__\n\n__Image Label|__Image|https://via.placeholder.com/50x50/000/fff__|User__\n\n__Detail Label|Tag|Detail__',
      input: '__Input|Enter your name__\n\n__Input|Enter email|email__\n\n__Input|Enter password|password__',
      divider: '___\n\n__Horizontal Divider|Or__\n\n__Vertical Divider|Or__',
      menu: '__Menu|[Home](# "active") [About](#) [Services](#) [Contact](#)__\n\n__Vertical Menu|[Dashboard](#) [Settings](#) [Profile](#)__',
      form: '__Form|\n  __Field|First Name__\n  __Input|Enter first name__\n  __Field|Email__\n  __Input|Enter your email__\n  __Primary Button|Submit__\n__',
      grid: '__Grid|\n  __Column|\n    ### Column 1\n    Some content here\n    __Button|Action 1__\n  __\n  __Column|\n    ### Column 2\n    More content here\n    __Button|Action 2|primary__\n  __\n__',
      table: '__Table|Name,Age,City,Role|John Doe,30,New York,Developer|Jane Smith,25,Los Angeles,Designer|Bob Johnson,35,Chicago,Manager__',
      breadcrumb: '__Breadcrumb|\n  __Section|Home__\n  __Divider|/__\n  __Section|Products__\n  __Divider|/__\n  __Active Section|Electronics__\n__',
      container: '__Container|This is content in a container__\n\n__Text Container|\n  # Header\n  This is text content in a container\n__',
      card: '__Card|\n  __Header|John Doe__\n  __Meta|Software Developer__\n  A passionate developer with 5 years of experience.\n__\n\n__Image Card|\n  ![Avatar](https://semantic-ui.com/images/avatar/large/matthew.png)\n  __Header|Matthew__\n  __Meta|Friend__\n__',
      comment: '__Comment|\n  __Avatar|__Image|https://via.placeholder.com/50x50/000/fff__|__\n  __Content|\n    __Author|John Doe__\n    __Metadata|2 hours ago__\n    __Text|This is a great project!__\n  __\n__',
      feed: '__Feed|\n  __Event|\n    __Label|__Image|https://via.placeholder.com/50x50/000/fff__|__\n    __Content|\n      __Summary|__User|John Doe__ added you as a friend__\n    __\n  __\n  __Event|\n    __Label|__Image|https://via.placeholder.com/50x50/000/fff__|__\n    __Content|\n      __Summary|You posted on __Group|Developers__ group__\n    __\n  __\n__',
      item: '__Item|\n  __Image|https://via.placeholder.com/100x100/000/fff__\n  __Content|\n    __Header|Project Title__\n    __Meta|Started 3 days ago__\n    __Description|Project description goes here.__\n    __Extra|__Label|New__\n  __\n__',
      statistic: '__Statistic|\n  __Value|1,200__\n  __Label|Downloads__\n__\n\n__Statistics|\n  __Statistic|\n    __Value|1,200__\n    __Label|Downloads__\n  __\n  __Statistic|\n    __Value|500__\n    __Label|Views__\n  __\n  __Statistic|\n    __Value|50__\n    __Label|Comments__\n  __\n__',
      modal: '__Modal|sample-modal__\n  __Header|Modal Title__\n  __Content|\n    __Image|https://via.placeholder.com/200x150/000/fff__\n    __Description|\n      __Header|Modal Content__\n      This is the content of the modal.\n    __\n  __\n  __Actions|\n    __Button|Cancel|secondary__\n    __Button|OK|primary__\n  __\n__',
      dropdown: '__Dropdown|Select Option|Option 1,Option 2,Option 3|placeholder="Choose an option"__\n\n__Selection Dropdown|Choose Country|United States,Canada,Mexico|multiple__\n\n__Search Dropdown|Skills|JavaScript,Python,Ruby,Go,TypeScript__|',
      accordion: '__Accordion|\n  __Title|Section 1__\n  __Content|This is the content for section 1__\n  __Title|Section 2__\n  __Content|This is the content for section 2__\n__',
      tab: '__Tab|Overview|active__\n  __Segment|This is the overview content__\n__\n__Tab|Details__\n  __Segment|This is the details content__\n__\n__Tab|Settings__\n  __Segment|This is the settings content__\n__',
      progress: '__Progress|75|Active Upload__\n\n__Progress|100|Completed__',
      loader: '__Loader__\n\n__Loader|Loading content__\n\n__Loader|Loading...|active__'
    };

    // Blockquote syntax examples
    this.blockquoteExamples = {
      button: '> Primary Button: Click Me\n\n> Secondary Button: Another Action\n\n> Button: Disabled\n\n> Large Button: Big Action',
      header: '> Large Header: Welcome to MarkdownUI\n\n> Medium Header: Section Title\n\n> Small Header: Subtitle\n\n> Dividing Header: Section Divider',
      message: '> Success Message: Everything worked perfectly!\n\n> Warning Message: Please be careful\n\n> Error Message: Something went wrong\n\n> Info Message: Here is some information\n\n> Message:\n> __Header:Changes in Service__\n> "We just updated our privacy policy here to better service our customers."',
      segment: '> Segment: This is a basic content segment.\n\n> Raised Segment: This segment is raised.\n\n> Secondary Segment: This is secondary content.\n\n> Compact Segment: Compact content.',
      icon: '> Icon: user\n\n> Icon: home\n\n> Icon: search\n\n> Icon: settings',
      flag: '> Flag: PH\n\n> Flag: France\n\n> Flag: Netherlands\n\n> Flag: US\n\n> Flag: UK\n\n> Flag: Germany',
      image: '> Image: https://via.placeholder.com/300x200/000/fff\n\n> Small Image: https://via.placeholder.com/100x100/000/fff\n\n> Large Image: https://via.placeholder.com/500x300/000/fff',
      label: '> Label: New\n\n> Image Label:\n> __Image: https://via.placeholder.com/50x50/000/fff__\n> User\n\n> Detail Label: Tag',
      input: '> Input: Enter your name\n\n> Input: Enter email\n\n> Input: Enter password',
      divider: '> Divider:\n> ___\n\n> Horizontal Divider: Or\n\n> Vertical Divider: Or',
      menu: '> Menu:\n> [Home](# "active")\n> [About](#)\n> [Services](#)\n> [Contact](#)\n\n> Vertical Menu:\n> [Dashboard](#)\n> [Settings](#)\n> [Profile](#)',
      form: '> Form:\n> __Field|First Name__\n> __Input|Enter first name__\n> __Field|Email__\n> __Input|Enter your email__\n> __Primary Button|Submit__',
      grid: '> Grid:\n> > Column:\n> > ### Column 1\n> > Some content here\n> > __Button|Action 1__\n> > \n> > Column:\n> > ### Column 2\n> > More content here\n> > __Button|Action 2__',
      table: '> Table: Name,Age,City,Role\n> John Doe,30,New York,Developer\n> Jane Smith,25,Los Angeles,Designer\n> Bob Johnson,35,Chicago,Manager',
      breadcrumb: '> Breadcrumb:\n> __Section|Home__\n> __Divider|/|__\n> __Section|Products__\n> __Divider|/|__\n> __Active Section|Electronics__',
      container: '> Container:\n> This is content in a container\n\n> Text Container:\n> # Header\n> This is text content in a container',
      card: '> Card:\n> **John Doe**\n> Software Developer\n>\n> A passionate developer with 5 years of experience.\n\n> Image Card:\n> ![Avatar](https://semantic-ui.com/images/avatar/large/matthew.png)\n> **Matthew**\n> Friend',
      comment: '> Comment:\n> __Avatar|__Image|https://via.placeholder.com/50x50/000/fff__|__\n> __Content|\n> __Author|John Doe__\n> __Metadata|2 hours ago__\n> __Text|This is a great project!__',
      feed: '> Feed:\n> __Event|\n> __Label|__Image|https://via.placeholder.com/50x50/000/fff__|__\n> __Content|\n> __Summary|__User|John Doe__ added you as a friend__\n> __\n> __Event|\n> __Label|__Image|https://via.placeholder.com/50x50/000/fff__|__\n> __Content|\n> __Summary|You posted on __Group|Developers__ group__',
      item: '> Item:\n> __Image|https://via.placeholder.com/100x100/000/fff__\n> __Content|\n> __Header|Project Title__\n> __Meta|Started 3 days ago__\n> __Description|Project description goes here.__\n> __Extra|__Label|New____',
      statistic: '> Statistic:\n> __Value|1,200__\n> __Label|Downloads__\n\n> Statistics:\n> __Statistic|\n> __Value|1,200__\n> __Label|Downloads__\n> __\n> __Statistic|\n> __Value|500__\n> __Label|Views__\n> __\n> __Statistic|\n> __Value|50__\n> __Label|Comments__',
      modal: '> Modal: sample-modal\n> __Header|Modal Title__\n> __Content|\n> __Image|https://via.placeholder.com/200x150/000/fff__\n> __Description|\n> __Header|Modal Content__\n> This is the content of the modal.\n> __\n> __\n> __Actions|\n> __Button|Cancel__\n> __Button|OK__',
      dropdown: '> Dropdown: Select Option\n> Option 1,Option 2,Option 3\n\n> Selection Dropdown: Choose Country\n> United States,Canada,Mexico\n\n> Search Dropdown: Skills\n> JavaScript,Python,Ruby,Go,TypeScript',
      accordion: '> Accordion:\n> __Title|Section 1__\n> __Content|This is the content for section 1__\n> __Title|Section 2__\n> __Content|This is the content for section 2__',
      tab: '> Tab: Overview\n> __Segment|This is the overview content__\n\n> Tab: Details\n> __Segment|This is the details content__\n\n> Tab: Settings\n> __Segment|This is the settings content__',
      progress: '> Progress: 75\n> Active Upload\n\n> Progress: 100\n> Completed',
      loader: '> Loader:\n\n> Loader: Loading content\n\n> Loader: Loading...'
    };

    // Get example based on current syntax mode
    const examples = this.syntaxMode === 'blockquote' ? this.blockquoteExamples : this.elementExamples;
    const example = examples[elementName];
    if (example) {
      const currentValue = this.editor.getValue();
      const newValue = currentValue ? currentValue + '\n\n' + example : example;
      this.editor.setValue(newValue);
    }
  }

  debouncedParse() {
    clearTimeout(this.parseTimeout);
    this.parseTimeout = setTimeout(() => {
      this.runCode();
    }, 500);
  }

  async runCode() {
    if (this.isRunning) return;

    this.isRunning = true;
    this.updateStatus('Parsing...', 'status-loading');

    try {
      const markdown = this.editor.getValue();

      // Check if WebAssembly is ready
      if (!this.rubyWasm || !this.rubyWasm.isInitialized) {
        throw new Error('Ruby WebAssembly is not available');
      }

      // Parse using WebAssembly Ruby parser
      console.log('Parsing with Ruby WebAssembly...');
      const html = await this.rubyWasm.parseMarkdown(markdown);

      // Update preview
      this.updatePreview(html);

      // Update HTML output
      this.updateHtmlOutput(html);

      this.updateStatus('Parsed successfully', 'status-ready');

    } catch (error) {
      console.error('Parse error:', error);
      this.updateStatus('Parse error: ' + error.message, 'status-error');
      this.updatePreview('<div class="ui error message"><div class="header">Parse Error</div><p>' + error.message + '</p></div>');
      this.updateHtmlOutput('<!-- Parse Error: ' + error.message + ' -->');
    } finally {
      this.isRunning = false;
    }
  }

  updatePreview(html) {
    const previewContainer = document.getElementById('preview-container');
    previewContainer.innerHTML = html;

    // Initialize Semantic UI components in the preview
    if (typeof $ !== 'undefined') {
      $(previewContainer).find('.ui.dropdown').dropdown();
      $(previewContainer).find('.ui.checkbox').checkbox();
      $(previewContainer).find('.ui.accordion').accordion();
      $(previewContainer).find('.ui.tab').tab();
    }
  }

  updateHtmlOutput(html) {
    const htmlOutput = document.getElementById('html-output');
    htmlOutput.textContent = html;
  }

  updateStatus(text, className = '') {
    const statusElement = document.getElementById('status-text');
    statusElement.textContent = text;
    statusElement.className = className;
  }

  updateWasmStatus(text, className = '') {
    const statusElement = document.getElementById('wasm-status');
    statusElement.textContent = text;
    statusElement.className = className;
  }

  loadExample() {
    const example = this.syntaxMode === 'blockquote' ?
      `# Welcome to MarkdownUI Online REPL

> Large Header: MarkdownUI Component Showcase

> Success Message: Explore all MarkdownUI components below!

## Elements

### Button
> Primary Button: Click Me
> Secondary Button: Another Action
> Basic Button: Basic
> Icon Button: _Shop Icon_ Add to Cart
> Labeled Icon Button: _Star Icon_ Rate
> Animated Button: Horizontal; Hidden
> Vertical Animated Button: _Shop Icon_; Shop
> Fade Animated Button: Sign-up for a Pro account;$12.99 a month

> Button: View
> Primary Button: Shop
> Secondary Button: Save
> Basic Button: Basic
> Icon Button: _Search Icon_
> Labeled Icon Button: _Heart Icon_ Like

### Divider
> Horizontal Divider: Or
> Vertical Divider: Or
> Header: Specifications, horizontal

### Flag
_US Flag_
_UK Flag_
_France Flag_
_Germany Flag_
_Japan Flag_
_China Flag_
_Canada Flag_
_Australia Flag_

### Header
> Large Header: H1 Header
> Medium Header: H2 Header
> Small Header: H3 Header
> Tiny Header: H4 Header
> Icon Header: _Settings Icon_ Settings
> Content Header: _User Icon_ User Management

### Icon
_Search Icon_
_Home Icon_
_Settings Icon_
_User Icon_
_Mail Icon_
_Calendar Icon_
_Star Icon_
_Heart Icon_

### Image
> Image: https://via.placeholder.com/300x200/000/fff
> Small Image: https://via.placeholder.com/150x150/000/fff
> Large Image: https://via.placeholder.com/500x300/000/fff
> Circular Image: https://via.placeholder.com/200x200/000/fff, circular

### Input
> Input: Enter your name
> Input: Enter email
> Input: Enter password
> Left Icon Input: _Search Icon_, Search...

### Label
> Label: New
> Blue Label: Popular
> Red Label: Sale
> Green Label: Featured
> Image Label: Elliot, https://via.placeholder.com/50x50/000/fff
> Detail Label: Tag

### List
> Bulleted List:
> __Item: First item__
> __Item: Second item__
> __Item: Third item__

> Ordered List:
> __Item: First step__
> __Item: Second step__
> __Item: Third step__

### Loader
> Loader: Loading content...
> Text Loader: Loading
> Indeterminate Loader: Processing

### Segment
> Segment: This is a basic segment
> Raised Segment: Raised content, raised
> Secondary Segment: Secondary content, secondary
> Compact Segment: Compact content, compact

> Steps:
> __Step: Title:Shipping, Description:Choose shipping__
> __Step: Title:Billing, Description:Enter payment__
> __Step: Title:Confirm, Description:Review order__

## Collections

### Breadcrumb
> Breadcrumb: Home, Products, Electronics, Laptops

### Form
> Form:
> __Field: First Name__
> __Input: Enter first name__
> __Field: Email__
> __Input: Enter email, email__
> __Checkbox: Subscribe to newsletter__
> __Button: Submit, primary__

### Grid
> Grid:
> __Two Columns Row:
>   __Column: Column 1__
>   __Column: Column 2__
> __
> __Three Columns Row:
>   __Column: Column 1__
>   __Column: Column 2__
>   __Column: Column 3__
> __

### Menu
> Menu:
> __Item: Home, active__
> __Item: About__
> __Item: Contact__

> Vertical Menu:
> __Item: Dashboard__
> __Item: Settings__
> __Item: Profile__

### Message
> Success Message: Operation completed successfully!
> Warning Message: Please review your input
> Error Message: Something went wrong
> Info Message: Here is some information

### Table
> Table: Name, Email, Role, Status |
> __Row: John Doe, john@example.com, Admin, Active__
> __Row: Jane Smith, jane@example.com, User, Active__
> __Row: Bob Wilson, bob@example.com, Manager, Inactive__

## Views

### Card
> Card:
> __Image: https://via.placeholder.com/300x200/000/fff__
> __Header: Card Title__
> __Meta: Meta info__
> __Description: This is a card description__
> __Extra: __Button: Learn More, primary____

### Feed
> Feed:
> __Event:
>   __Label: __Image: https://via.placeholder.com/50x50/000/fff____
>   __Content:
>     __Summary: User posted an update__
>     __Date: 2 hours ago__
>   __
> __

### Item
> Items:
> __Item:
>   __Image: https://via.placeholder.com/150x150/000/fff__
>   __Header: Item Title__
>   __Meta: Date, Category__
>   __Description: Item description__
>   __Extra: __Button: View Details, primary____
> __

### Statistic
> Statistic:
> __Value: 1,234__
> __Label: Downloads__

> Statistics:
> __Statistic: __Value: 567__ __Label: Views____
> __Statistic: __Value: 89__ __Label: Likes____

## Modules

### Accordion
> Accordion:
> __Title: Section 1__
> __Content: This is the content for section 1__
> __Title: Section 2__
> __Content: This is the content for section 2__

### Checkbox
> Checkbox: checkbox1
> Radio: radio1, option1
> Radio: radio1, option2
> Toggle: toggle1

### Dropdown
> Dropdown: Select Option, Option 1, Option 2, Option 3
> Selection Dropdown: Choose Country, United States, Canada, Mexico
> Search Dropdown: Skills, JavaScript, Python, Ruby

### Modal
> Modal: demo-modal
> __Header: Modal Title__
> __Content: This is modal content__
> __Actions: __Button: Cancel__ __Button: OK, primary____

### Progress
> Progress: 75, Active Upload
> Progress: 100, Completed
> Progress: 45, Processing

### Rating
> Star Rating: 4, 5
> Heart Rating: 3, 5

### Tab
> Tab: Overview, active
> __Segment: This is the overview content__
>
> Tab: Details
> __Segment: This is the details content__

### Search
> Search: Local search...
> Remote Search: Remote search...
> Category Search: Category search...

---

*This comprehensive example demonstrates all MarkdownUI components!*` :

      `# Welcome to MarkdownUI Online REPL

__Large Header|MarkdownUI Component Showcase__

__Success Message|Explore all MarkdownUI components below!__

## Elements

### Button
__Button|View__
__Primary Button|Click Me|primary__
__Secondary Button|Another Action|secondary__
__Basic Button|Basic|basic__
__Icon Button|Icon:Shop, Add to Cart__
__Labeled Icon Button|Icon:Star, Rate
__Animated Button|Text:Next;Icon:Right Arrow__
__Vertical Animated Button|Icon:Shop;Text:Shop__
__Fade Animated Button|Text:Sign-up for a Pro account;Text:$12.99 a month__

__Button|View__
__Primary Button|Shop|primary__
__Secondary Button|Save|secondary__
__Basic Button|Basic|basic__
__Icon Button|Icon:Search
__Labeled Icon Button|Icon:Heart, Like

### Divider
___
__Horizontal Divider|Or__
__Vertical Divider|Or__
__Header|Specifications|horizontal__

### Flag
_US Flag_
_UK Flag_
_France Flag_
_Germany Flag_
_Japan Flag_
_China Flag_
_Canada Flag_
_Australia Flag_

### Header
__Large Header|H1 Header__
__Medium Header|H2 Header__
__Small Header|H3 Header__
__Tiny Header|H4 Header__
__Icon Header|Icon:Settings, Settings
__Content Header|Icon:User, User Management

### Icon
_Search Icon_
_Home Icon_
_Settings Icon_
_User Icon_
_Mail Icon_
_Calendar Icon_
_Star Icon_
_Heart Icon_

### Image
__Image|https://via.placeholder.com/300x200/000/fff__
__Image|https://via.placeholder.com/150x150/000/fff|small__
__Image|https://via.placeholder.com/500x300/000/fff|large__
__Image|https://via.placeholder.com/200x200/000/fff|circular__

### Input
__Input|Enter your name__
__Input|Enter email|email__
__Input|Enter password|password__
__Input|Search...|icon search__

### Label
__Label|New__
__Label|Popular|blue__
__Label|Sale|red__
__Label|Featured|green__
__Image Label|Elliot|https://via.placeholder.com/50x50/000/fff__
__Detail Label|Tag__

### List
__Bulleted List|
  First item
  Second item
  Third item
__

__Ordered List|
  First step
  Second step
  Third step
__

### Loader
__Loader|Loading content...__
__Text Loader|Loading__
__Indeterminate Loader|Processing__

### Segment
__Segment|This is a basic segment__
__Raised Segment|Raised content|raised__
__Secondary Segment|Secondary content|secondary__
__Compact Segment|Compact content|compact__

### Menu
__Menu|[Home](# "active") [About](#) [Contact](#)__

__Vertical Menu|[Dashboard](#) [Settings](#) [Profile](#)__

__Secondary Menu|[Home](# "active") [Messages](#) [Friends](#)__

__Pointing Menu|[Home](# "active") [Messages](#) [Friends](#)__

__Tabular Menu|[Home](# "active") [About](#) [Contact](#)__

__Pagination Menu|[&laquo;](#) [1](# "active") [2](#) [3](#) [&raquo;](#)__

## Collections

### Breadcrumb
__Breadcrumb|Home, Products, Electronics, Laptops|large__

### Form
> Form:
> __Field|First Name__
> __Input|Enter first name__
> __Field|Email__
> __Input|Enter email__
> __Checkbox|Subscribe to newsletter__
> __Button|Submit|primary__

### Grid
> Grid:
> > Two Columns Row:
> > __Column|Column 1__
> > __Column|Column 2__

> > Three Columns Row:
> > __Column|Column 1__
> > __Column|Column 2__
> > __Column|Column 3__

### Message
__Success Message|Operation completed successfully!__
__Warning Message|Please review your input|warning__
__Error Message|Something went wrong|error__
__Info Message|Here is some information|info__

### Table
__Table|Name, Email, Role, Status|
  John Doe, john@example.com, Admin, Active
  Jane Smith, jane@example.com, User, Active
  Bob Wilson, bob@example.com, Manager, Inactive
__

__Table|Name, Age, Job|
  John, 30, Developer
  Jane, 25, Designer
__

__Table|striped|Name, Email, Role, Status|
  John Doe, john@example.com, Admin, Active
  Jane Smith, jane@example.com, User, Active
  Bob Wilson, bob@example.com, Manager, Inactive
__

## Views

### Card
__Card|Header:Card Title,Meta:Meta info,Description:This is a card description__

### Feed
> Feed:
> > Event:
> > ![Avatar](https://via.placeholder.com/50x50/000/fff)
> > **User Name**
> > User posted an update
> > 2 hours ago

### Item
> Items:
> > Item:
> > ![Item](https://via.placeholder.com/150x150/000/fff)
> > **Item Title**
> > Date, Category
> > Item description
> > __Button|View Details|primary__

### Statistic
> Statistic:
> **1,234**
> Downloads

> Statistics:
> > Statistic:
> > **567**
> > Views
> > Statistic:
> > **89**
> > Likes

## Modules

### Accordion
> Accordion:
> > Title: Section 1
> > Content: This is the content for section 1
> > Title: Section 2
> > Content: This is the content for section 2

### Checkbox
__Checkbox|checkbox1__
__Radio|radio1|option1__
__Radio|radio1|option2__
__Toggle|toggle1__

### Dropdown
__Dropdown|Select Option|Option 1,Option 2,Option 3__
__Selection Dropdown|Choose Country|United States,Canada,Mexico__
__Search Dropdown|Skills|JavaScript,Python,Ruby__

### Modal
> Modal:
> **Modal Title**
> This is modal content
> __Button|Cancel__
> __Button|OK|primary__

### Progress
__Progress|75__
__Progress|Active Upload|60__
__Progress|Loading|45|indicating__
__Progress|Complete|100|success__

### Rating
__Rating|4|5__
__Rating|3|5__

### Tab
> Tab: Overview, active
> __Segment|This is the overview content__

> Tab: Details
> __Segment|This is the details content__

### Search
__Search|Local search...__
__Remote Search|Remote search...__
__Category Search|Category search...__

---

*This comprehensive example demonstrates all MarkdownUI components!*`;

    this.editor.setValue(example);
  }

  exportCode() {
    const html = document.getElementById('preview-container').innerHTML;

    const blob = new Blob([html], {
      type: 'text/html'
    });

    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'markdown-ui-export.html';
    a.click();

    URL.revokeObjectURL(url);
  }

  shareCode() {
    const markdown = this.editor.getValue();
    const encoded = btoa(markdown);
    const url = window.location.origin + window.location.pathname + '?code=' + encoded;

    // Copy to clipboard
    navigator.clipboard.writeText(url).then(() => {
      // Show success message
      const shareBtn = document.getElementById('share-btn');
      const originalText = shareBtn.innerHTML;
      shareBtn.innerHTML = '<i class="check icon"></i> Copied!';
      setTimeout(() => {
        shareBtn.innerHTML = originalText;
      }, 2000);
    });
  }

  loadFromUrl() {
    const urlParams = new URLSearchParams(window.location.search);
    const code = urlParams.get('code');

    if (code) {
      try {
        const markdown = atob(code);
        this.editor.setValue(markdown);
      } catch (error) {
        console.warn('Invalid code in URL:', error);
      }
    }
  }
}

// Global instance
window.MarkdownUIREPL = new MarkdownUIREPL();
