# MarkdownUI V2: Dual Syntax Guide

MarkdownUI V2 supports **two powerful syntax patterns** for maximum flexibility and expressiveness:

## 📝 Inline Syntax: `__Element|param1|param2|modifiers__`

Perfect for **simple, self-contained components** with defined parameters.

### Examples:
```markdown
__Button|Save Changes|primary large__
__Progress|Upload Progress|75|indicating blue__
__Label|New Feature|green tag__
__Table|Name,Status|John,Active|Jane,Inactive|striped celled__
```

### Best for:
- Simple elements with clear parameters
- Data-driven components (tables, progress bars)
- Action elements (buttons, links)
- Quick inline components

## 📦 Container Syntax: `> Element:\n> content...`

Perfect for **complex, multi-line content** with nested structure.

### Examples:
```markdown
> Grid:
> Column 1 with complex content
> Column 2 with more content  
> Column 3 with even more content

> Segment:
> ## Welcome Section
> This segment can contain multiple paragraphs,
> markdown formatting, and complex layouts.

> Message:
> ### Important Notice
> This is a multi-line message that can include:
> - Rich content
> - Multiple paragraphs
> - Complex formatting
```

### Best for:
- Multi-line content
- Rich text with formatting
- Complex layouts
- Nested structures

## 🔀 Mixed Usage: Best of Both Worlds

You can seamlessly combine both syntaxes in the same document:

```markdown
__Header|Welcome to Our App|h1 blue__

> Message:
> ### Getting Started  
> Welcome! Here's a comprehensive guide using both syntax patterns.
> Container syntax is perfect for multi-line explanatory content.

__Progress|Setup Progress|75|indicating green__

> Segment:
> ## Quick Actions
> Try these __Button|inline buttons|primary__ within container content!
> 
> Or use standalone buttons below:

__Button|Get Started|large primary__ __Button|Learn More|secondary__
```

## 🎯 Element Compatibility

### ✅ Supports Both Syntaxes
| Element | Inline Example | Container Example |
|---------|----------------|-------------------|
| **Grid** | `__Grid\|Col1\|Col2\|Col3__` | `> Grid:\n> Content 1\n> Content 2` |
| **Segment** | `__Segment\|Content\|raised__` | `> Segment:\n> Multi-line content` |
| **Message** | `__Message\|Alert text\|info__` | `> Message:\n> Complex message` |
| **Container** | `__Container\|Text content\|fluid__` | `> Container:\n> Rich content` |
| **Card** | `__Card\|Card content\|raised__` | `> Card:\n> ## Title\n> Description` |

### 📝 Inline-Only Elements
These work best with parameters and short content:
- **Button**: `__Button|Click Me|primary__`
- **Progress**: `__Progress|Loading|50|blue__`
- **Input**: `__Input|Enter name|text required__`
- **Dropdown**: `__Dropdown|Choose|Option1|Option2__`
- **Table**: `__Table|headers|row1|row2|striped__`

## 🏗️ Architecture Benefits

### Tokenizer Intelligence
The V2 tokenizer automatically detects and parses both patterns:

```ruby
# Both syntaxes produce the same result:
parser.parse('__Segment|Hello World|raised__')
parser.parse("> Segment:\n> Hello World")
# Both render: <section class="ui raised segment">Hello World</section>
```

### Element Registry
All 29+ UI elements support the appropriate syntax patterns:
- **29 Total Elements** implemented
- **Smart content parsing** for both syntaxes
- **Automatic modifier detection**
- **Consistent output** regardless of input syntax

## 🚀 Real-World Examples

### Dashboard (Mixed Syntax)
```markdown
__Header|System Dashboard|h1 blue__

> Grid:
> ## Server Status
> All systems operational
> Last check: 2 minutes ago
> 
> ## Performance Metrics  
> __Progress|CPU Usage|45|green__
> __Progress|Memory|67|yellow__
> __Progress|Disk|23|blue__

__Table|Service,Status,Uptime|Web,Online,99.9%|DB,Online,99.8%|striped__

> Message:
> ### 📊 System Health: Excellent
> All services are running normally with optimal performance.
```

### Form (Container Syntax)
```markdown
> Form:
> ## User Registration
> 
> Please fill out all required fields below.
> Your information will be kept secure and private.

__Field|Full Name|required__
__Input|Enter your full name|text__

__Field|Email Address|required__  
__Input|your.email@example.com|email__

__Checkbox|I agree to the terms and conditions|required__
__Button|Create Account|primary large__
```

## ✨ Key Features

1. **🔄 Syntax Flexibility**: Choose the right syntax for each use case
2. **🎯 Consistent Output**: Same HTML regardless of input syntax  
3. **🏗️ Smart Parsing**: Automatic content structure detection
4. **📦 Rich Content**: Full markdown support in container syntax
5. **🔀 Mixed Usage**: Seamlessly combine both patterns
6. **⚡ Performance**: Efficient tokenization and parsing

## 🎉 Conclusion

MarkdownUI V2's dual syntax support provides unmatched flexibility:

- Use **inline syntax** for simple, parameter-driven components
- Use **container syntax** for rich, multi-line content  
- **Mix both** for optimal expressiveness
- **29+ elements** all support appropriate patterns
- **Production-ready** with comprehensive error handling

**The result: Clean, maintainable markup with maximum expressive power!** ✨