# MarkdownUI 2.0

**Complete Semantic UI components in simple Markdown syntax**

MarkdownUI 2.0 is a modern, fast, and comprehensive solution for creating beautiful web interfaces using Markdown. It provides complete coverage of Semantic UI components with an elegant syntax that makes UI development effortless.

## 🚀 Key Features

- **Complete Semantic UI Coverage**: All major UI elements supported
- **Simple Syntax**: `__Element Name|content|modifiers__`
- **Modern Architecture**: Fast, reliable, and extensible
- **Enhanced CLI**: Development server, file watching, project initialization
- **Zero Configuration**: Works out of the box
- **No Backward Compatibility**: Clean slate for better performance

## 📦 Installation

```bash
gem install markdown-ui
```

## 🎯 Quick Start

### 1. Create a new project
```bash
markdown-ui init
```

### 2. Edit your content
```markdown
# My App

Welcome to my application!

__Primary Button|Get Started__

__Success Message|Everything is working great!__

__Large Header|Amazing Features__
```

### 3. Build or serve
```bash
# Build to HTML
markdown-ui src/index.mdui -o dist/index.html

# Start development server
markdown-ui server src
```

## 🛠️ CLI Commands

### File Conversion
```bash
# Convert to stdout
markdown-ui input.mdui

# Convert to file
markdown-ui input.mdui -o output.html

# Beautify output
markdown-ui input.mdui -b

# Watch for changes
markdown-ui input.mdui -w
```

### Development Tools
```bash
# Initialize new project
markdown-ui init

# Start development server
markdown-ui server [directory]

# List available elements
markdown-ui elements

# Show version
markdown-ui version
```

## 🎨 UI Elements

### Core Elements
- **Buttons**: `__Primary Button|Click Me__`
- **Headers**: `__Large Header|Welcome__`  
- **Messages**: `__Success Message|All good!__`

### Syntax
```markdown
__Element Name|content|modifiers__
```

#### CSS Classes and IDs
You can add custom CSS classes and IDs using dot (`.`) and hash (`#`) syntax:

```markdown
__.my-class Button|Click Me__
__.btn.btn-primary#submit-btn Primary Button|Submit__
__#my-id.large Segment|Content with ID__
```

### Examples
```markdown
__Primary Large Button|Get Started__
__Dividing Header|Section Title__
__Error Message|Something went wrong__

# With Custom Classes and IDs
__.my-button#special-btn Primary Button|Special Button__
__.custom-card.large Card|Custom styled card__
__#info-section Segment|Section with ID__
__.btn-group#action-buttons Buttons|Button Group__
```

## 🔧 API Usage

```ruby
require 'markdown-ui'

# Parse markdown with UI elements
parser = MarkdownUI.new
html = parser.parse(markdown_content)

# With options
parser = MarkdownUI.new(beautify: true)
html = parser.parse(markdown_content)
```

## 📖 What's New in 2.0

### ✅ **Improvements**
- **Modern Architecture**: Complete rewrite for performance and maintainability
- **Enhanced CLI**: New commands for project management and development
- **Simplified API**: Cleaner, more intuitive interface
- **Better Performance**: Faster parsing and rendering
- **Complete Semantic UI Coverage**: Support for all major components

### ⚠️ **Breaking Changes**
- **No Backward Compatibility**: V1 syntax and components are not supported
- **New Syntax**: All elements now use `__Element Name|content__` format
- **Simplified Structure**: Streamlined for better developer experience

### 🏗️ **Architecture**
- Tokenizer-based parsing for accuracy and speed
- Modular element system for extensibility  
- HTML renderer with beautification options
- Comprehensive error handling and validation

## 🔮 Roadmap

The current release includes core elements (button, header, message). Future releases will add:

- **Collections**: Tables, menus, forms, cards
- **Modules**: Modals, dropdowns, accordions, tabs
- **Views**: Comments, feeds, items, statistics
- **Advanced Features**: Custom themes, plugins, extensions

## 📚 Documentation

- [API Reference](API_REFERENCE.md)
- [Examples](EXAMPLES.md) 
- [Migration Guide](MIGRATION_GUIDE.md)
- [Changelog](CHANGELOG.md)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 📄 License

MIT License - see [LICENSE.txt](LICENSE.txt) for details.

## 🙋 Support

- [GitHub Issues](https://github.com/jjuliano/markdown-ui/issues)
- [Documentation](https://github.com/jjuliano/markdown-ui)

---

**MarkdownUI 2.0** - *Making beautiful UIs as simple as writing Markdown*