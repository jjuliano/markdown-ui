# Markdown UI - API Reference

Complete reference for all Markdown UI components, syntax patterns, and usage examples.

## 📋 Table of Contents

1. [Syntax Patterns](#syntax-patterns)
2. [Perfect Components (100%)](#perfect-components-100)
3. [Near-Perfect Components (90%+)](#near-perfect-components-90)
4. [Good Components (60%+)](#good-components-60)
5. [Ruby API](#ruby-api)
6. [Advanced Usage](#advanced-usage)
7. [CSS Integration](#css-integration)

---

## Syntax Patterns

Markdown UI uses two main syntax patterns for different types of components:

### Double Emphasis Pattern
For inline/self-contained components: `__Component|param1|param2|param3__`

```markdown
__Button|Click Me|primary large__
__Label|Status|green__
__Progress|Loading|75|indicating__
__Table|striped|Header1,Header2|Row1Col1,Row1Col2__
```

### Block Quote Pattern
For container components: `> Component:` followed by content

```markdown
> Segment:
> Content goes here

> Menu:
> [Link 1](#)
> [Link 2](#)

> Message:
> ### Header
> Message content
```

### Nested Components
Use multiple `>` for nesting levels:

```markdown
> Grid:
> > Column:
> > > Segment:
> > > Nested content

> Menu:
> [Home](#)
> > Right Menu:
> > [Logout](#)
```

---

## Perfect Components (100%)

Components with 100% test coverage and full reliability.

### Table Component ✅

**Status**: 12/12 tests passing (100%)  
**Syntax**: `__Table|options|headers|row1|row2|...rowN__`

#### Parameters
1. **Component**: `Table` (case-insensitive)
2. **Options**: CSS modifiers (optional)
3. **Headers**: Comma-separated column headers
4. **Rows**: Pipe-separated rows, comma-separated values within rows

#### Examples

**Basic Table**
```markdown
__Table||Name,Age,Status|John,25,Active|Jane,30,Inactive__
```
```html
<table class="ui table">
  <thead>
    <tr><th>Name</th><th>Age</th><th>Status</th></tr>
  </thead>
  <tbody>
    <tr><td>John</td><td>25</td><td>Active</td></tr>
    <tr><td>Jane</td><td>30</td><td>Inactive</td></tr>
  </tbody>
</table>
```

**Styled Table**
```markdown
__Table|striped celled|Product,Price,Stock|iPhone 13,$999,Available|MacBook Pro,$2499,Limited__
```
```html
<table class="ui striped celled table">
  <thead>
    <tr><th>Product</th><th>Price</th><th>Stock</th></tr>
  </thead>
  <tbody>
    <tr><td>iPhone 13</td><td>$999</td><td>Available</td></tr>
    <tr><td>MacBook Pro</td><td>$2499</td><td>Limited</td></tr>
  </tbody>
</table>
```

**Advanced Table Options**
```markdown
__Table|very basic selectable|Column A,Column B|Value 1,Value 2|Value 3,Value 4__
```

#### Supported Options
- `striped`, `celled`, `basic`, `very basic`
- `compact`, `selectable`, `inverted`
- `sortable`, `unstackable`, `fixed`
- Color variations: `red`, `orange`, `yellow`, `olive`, `green`, `teal`, `blue`, `violet`, `purple`, `pink`, `brown`, `grey`, `black`

---

### Progress Component ✅

**Status**: 15/15 tests passing (100%)  
**Syntax**: `__Progress|label|percentage|options__`

#### Parameters
1. **Component**: `Progress` (case-insensitive)
2. **Label**: Display text for the progress bar
3. **Percentage**: Numeric value 0-100
4. **Options**: CSS modifiers (optional)

#### Examples

**Basic Progress**
```markdown
__Progress|Loading|50__
```
```html
<div class="ui progress">
  <div class="bar" style="width: 50%;">
    <div class="progress">50%</div>
  </div>
  <div class="label">Loading</div>
</div>
```

**Indicating Progress**
```markdown
__Progress|Upload Complete|100|indicating success__
```
```html
<div class="ui indicating success progress">
  <div class="bar" style="width: 100%;">
    <div class="progress">100%</div>
  </div>
  <div class="label">Upload Complete</div>
</div>
```

**Colored Progress**
```markdown
__Progress|Processing Data|75|blue__
```

#### Supported Options
- States: `indicating`, `success`, `warning`, `error`, `active`
- Colors: `red`, `orange`, `yellow`, `olive`, `green`, `teal`, `blue`, `violet`, `purple`, `pink`, `brown`, `grey`, `black`
- Sizes: `tiny`, `small`, `medium`, `large`, `big`, `huge`, `massive`

---

### Flag Component ✅

**Status**: 1/1 tests passing (100%)  
**Syntax**: `__Flag|country__`

#### Parameters
1. **Component**: `Flag` (case-insensitive)
2. **Country**: ISO 3166-1 alpha-2 country code

#### Examples

**Country Flags**
```markdown
__Flag|us__ __Flag|gb__ __Flag|ca__ __Flag|de__ __Flag|fr__
```
```html
<i class="us flag"></i> <i class="gb flag"></i> <i class="ca flag"></i> <i class="de flag"></i> <i class="fr flag"></i>
```

#### Supported Countries
All ISO 3166-1 alpha-2 country codes are supported (us, gb, ca, de, fr, jp, cn, etc.)

---

### Menu Component ✅

**Status**: 11/11 tests passing (100%)  
**Syntax**: `> MenuType Menu:` followed by menu items

#### Basic Syntax
```markdown
> Menu:
> [Item Text](url)
> [Item Text](url "class-modifier")
```

#### Examples

**Basic Menu**
```markdown
> Three Item Menu:
> [Home](/ "active")
> [Products](/products)
> [Contact](/contact)
```
```html
<div class="ui three item menu">
  <a class="ui active item" href="/">Home</a>
  <a class="ui item" href="/products">Products</a>
  <a class="ui item" href="/contact">Contact</a>
</div>
```

**Nested Menu**
```markdown
> Secondary Menu:
> [Home](/ "active")
> [Products](/products)
> > Right Menu:
> > [Login](/login)
> > [Register](/register)
```
```html
<div class="ui secondary menu">
  <a class="ui active item" href="/">Home</a>
  <a class="ui item" href="/products">Products</a>
  <div class="ui right menu">
    <a class="ui item" href="/login">Login</a>
    <a class="ui item" href="/register">Register</a>
  </div>
</div>
```

**Vertical Menu with Labels**
```markdown
> Vertical Menu:
> [Inbox __Div Tag|1|Teal Pointing Left Label__](# "active teal item")
> [Spam __Div Tag|51|Label__](#)
> [Updates __Div Tag|1|Label__](#)
```

#### Supported Menu Types
- `Menu` (basic)
- `Secondary Menu`
- `Pointing Menu`
- `Secondary Pointing Menu`  
- `Tabular Menu`
- `Top Attached Tabular Menu`
- `Vertical Menu`
- `Vertical Fluid Tabular Menu`
- `Text Menu`
- `Pagination Menu`

#### Item States
- `active` - Active/current item
- `disabled` - Disabled item

---

### Message Component ✅

**Status**: 5/5 tests passing (100%)  
**Syntax**: `> MessageType Message:` followed by content

#### Examples

**Basic Message**
```markdown
> Message:
> ### Changes in Service
> We updated our privacy policy to better serve customers.
```
```html
<div class="ui message">
  <div class="ui header">Changes in Service</div>
  <p>We updated our privacy policy to better serve customers.</p>
</div>
```

**Info Message with List**
```markdown
> Info Message:
> ### New Site Features
> - You can now have cover images on blog pages
> - Drafts will now auto-save while writing
```
```html
<div class="ui info message">
  <div class="ui header">New Site Features</div>
  <ul class="ui unordered list">
    <li>You can now have cover images on blog pages</li>
    <li>Drafts will now auto-save while writing</li>
  </ul>
</div>
```

#### Supported Message Types
- `Message` (basic)
- `Info Message`
- `Warning Message`
- `Error Message`
- `Success Message`
- `Positive Message`
- `Negative Message`

---

### Segment Component ✅

**Status**: 14/14 tests passing (100%)  
**Syntax**: `> SegmentType Segment:` followed by content

#### Examples

**Basic Segment**
```markdown
> Segment:
> This is a basic segment containing some content.
```
```html
<div class="ui segment">
  <p>This is a basic segment containing some content.</p>
</div>
```

**Raised Segment**
```markdown
> Raised Segment:
> This segment appears elevated from the page.
```
```html
<div class="ui raised segment">
  <p>This segment appears elevated from the page.</p>
</div>
```

**Nested Segments**
```markdown
> Segment:
> ## Outer Segment
> > Nested Segment:
> > This is nested inside the outer segment.
```

#### Supported Segment Types
- `Segment` (basic)
- `Raised Segment`
- `Stacked Segment`
- `Piled Segment`
- `Vertical Segment`
- `Horizontal Segment`
- `Padded Segment`
- Color variants: `Red Segment`, `Blue Segment`, etc.

---

## Near-Perfect Components (90%+)

### Button Component 🔥

**Status**: 57/58 tests passing (98.3%)  
**Syntax**: `__Button|content|options__`

#### Parameters
1. **Component**: `Button` (case-insensitive)
2. **Content**: Button text or `Icon:iconname` for icons
3. **Options**: CSS modifiers (space-separated)

#### Examples

**Basic Buttons**
```markdown
__Button|Click Me__
__Button|Primary Action|primary__
__Button|Large Secondary|large secondary__
```
```html
<button class="ui button">Click Me</button>
<button class="ui primary button">Primary Action</button>
<button class="ui large secondary button">Large Secondary</button>
```

**Icon Buttons**
```markdown
__Button|Icon:save|Save Document|labeled icon__
__Button|Icon:download|Download|icon__
```
```html
<button class="ui labeled icon button">
  <i class="save icon"></i>
  Save Document
</button>
<button class="ui icon button">
  <i class="download icon"></i>
</button>
```

**Colored Buttons**
```markdown
__Button|Delete|red__
__Button|Success|green__
__Button|Info|blue__
```

#### Supported Options
- **Colors**: `red`, `orange`, `yellow`, `olive`, `green`, `teal`, `blue`, `violet`, `purple`, `pink`, `brown`, `grey`, `black`
- **Sizes**: `mini`, `tiny`, `small`, `medium`, `large`, `big`, `huge`, `massive`
- **States**: `active`, `disabled`, `loading`
- **Types**: `primary`, `secondary`, `basic`, `inverted`, `tabular`, `toggle`, `fluid`, `circular`
- **Icons**: `icon`, `labeled icon`, `right labeled icon`

#### Known Issues
- 1 test failing related to complex button group parsing
- Button groups work for simple cases but have edge cases with mixed content

---

### Divider Component 🔥

**Status**: 8/9 tests passing (88.9%)  
**Syntax**: `> DividerType Divider:` with `&nbsp;` content

#### Examples

**Basic Divider**
```markdown
> Segment:
> Content above the divider
> > Divider:
> > &nbsp;
> Content below the divider
```
```html
<div class="ui segment">
  <p>Content above the divider</p>
  <div class="ui divider"></div>
  <p>Content below the divider</p>
</div>
```

**Styled Dividers**
```markdown
> > Hidden Divider:
> > &nbsp;

> > Fitted Divider:
> > &nbsp;

> > Clearing Divider:
> > &nbsp;
```

#### Supported Divider Types
- `Divider` (basic)
- `Hidden Divider`
- `Fitted Divider` 
- `Clearing Divider`
- `Vertical Divider` (with content)

#### Known Issues
- 1 test failing related to complex form integration
- Works perfectly for all basic divider use cases

---

## Good Components (60%+)

### Label Component 🚧

**Status**: 9/13 tests passing (69.2%)  
**Syntax**: `__Label|content|options__`

#### Parameters
1. **Component**: `Label` (case-insensitive)
2. **Content**: Label text
3. **Options**: CSS modifiers and special configurations

#### Examples

**Basic Labels**
```markdown
__Label|New Feature|green__
__Label|Priority|red__
__Label|Status|basic blue__
```
```html
<div class="ui green label">New Feature</div>
<div class="ui red label">Priority</div>
<div class="ui basic blue label">Status</div>
```

**Sized Labels**
```markdown
__Label|Mini|mini__
__Label|Small|small__
__Label|Large|large__
```

**Shaped Labels**
```markdown
__Label|1|circular__
__Label|Featured|tag__
__Label|Special Offer|ribbon__
```

#### Working Features ✅
- Basic colored labels
- Size variations (mini, tiny, small, large, etc.)
- Basic modifiers (basic, circular, tag, ribbon, pointing)
- Color combinations

#### Partially Working Features 🚧
- **Image Labels**: Syntax parsing works, but image extraction needs improvement
- **Icon Labels**: CSS classes apply, but icon HTML structure needs work
- **Detail Labels**: Basic structure works, but detail separation needs refinement
- **Corner Labels**: CSS applies, but content handling needs adjustment

#### Supported Options
- **Colors**: All Semantic UI colors (red, green, blue, etc.)
- **Sizes**: `mini`, `tiny`, `small`, `medium`, `large`, `big`, `huge`, `massive`
- **Types**: `basic`, `circular`, `tag`, `ribbon`, `pointing`
- **Special**: `image`, `icon`, `detail`, `corner` (partially supported)

---

## Ruby API

### Basic Usage

```ruby
require 'markdown-ui'

# Create parser instance
parser = MarkdownUI::Parser.new

# Render markdown to HTML
html = parser.render(markdown_content)
```

### Parser Options

```ruby
# Default parser (recommended)
parser = MarkdownUI::Parser.new

# Custom Redcarpet options (advanced)
parser = MarkdownUI::Parser.new(
  extensions: [:tables, :fenced_code_blocks],
  render_options: [:hard_wrap]
)
```

### Component Testing

```ruby
# Test individual components
parser = MarkdownUI::Parser.new

# Test a table
table_html = parser.render('__Table|striped|Name,Age|John,25__')

# Test a progress bar  
progress_html = parser.render('__Progress|Loading|50|indicating__')

# Test a menu
menu_html = parser.render('> Menu: [Home](#) [About](#)')
```

### Error Handling

```ruby
begin
  html = parser.render(markdown_content)
rescue MarkdownUI::ParseError => e
  puts "Parsing error: #{e.message}"
rescue => e
  puts "Unexpected error: #{e.message}"
end
```

---

## Advanced Usage

### Complex Layouts

```ruby
complex_markdown = <<~MARKDOWN
  # Dashboard

  > Grid:
  > > Four Wide Column:
  > > > Vertical Menu:
  > > > [Overview](/ "active")
  > > > [Reports](/reports)
  > > > [Settings](/settings)

  > > Twelve Wide Column:
  > > > Segment:
  > > > ## Welcome Back!
  > > > 
  > > > __Progress|Task Completion|85|indicating success__
  > > > 
  > > > __Table|celled striped|Task,Status,Progress|Design,Complete,100%|Development,In Progress,75%|Testing,Pending,0%__
  > > > 
  > > > __Button|View Details|primary large__
MARKDOWN

html = parser.render(complex_markdown)
```

### Component Combinations

```ruby
# Combine multiple components
combined_content = <<~MARKDOWN
  > Info Message:
  > ### System Status
  > All systems are operational.
  > 
  > __Progress|Server Load|25|green__
  > __Progress|Memory Usage|60|yellow__
  > __Progress|Disk Space|80|orange indicating__

  __Table|compact|Service,Status,Uptime|Web Server,__Label|Online|green__,99.9%|Database,__Label|Online|green__,99.8%|Cache,__Label|Maintenance|yellow__,95.2%__
MARKDOWN

html = parser.render(combined_content)
```

### Dynamic Content Generation

```ruby
class DashboardGenerator
  def initialize
    @parser = MarkdownUI::Parser.new
  end

  def generate_table(data)
    headers = data.first.keys.join(',')
    rows = data.map { |row| row.values.join(',') }.join('|')
    @parser.render("__Table|striped celled|#{headers}|#{rows}__")
  end

  def generate_progress(label, value, options = "")
    @parser.render("__Progress|#{label}|#{value}|#{options}__")
  end
end

# Usage
generator = DashboardGenerator.new
data = [
  {name: "John", age: 25, status: "Active"},
  {name: "Jane", age: 30, status: "Inactive"}
]

table_html = generator.generate_table(data)
progress_html = generator.generate_progress("Loading", 75, "indicating")
```

---

## CSS Integration

### Required CSS

Include Semantic UI CSS for proper styling:

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
```

### Optional JavaScript

For interactive components, include Semantic UI JavaScript:

```html
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
```

### Custom Styling

```css
/* Custom overrides */
.ui.table {
  border-radius: 8px;
}

.ui.progress .bar {
  transition: width 0.3s ease;
}

.ui.menu {
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
```

### Theme Customization

```css
/* Custom color theme */
.ui.primary.button,
.ui.primary.buttons .button {
  background-color: #6366f1;
}

.ui.green.label {
  background-color: #10b981 !important;
}

.ui.indicating.progress .bar {
  background: linear-gradient(45deg, #6366f1, #8b5cf6);
}
```

---

## Component Development Guide

### Adding New Components

1. **Create Component Structure**
```ruby
# components/elements/markdown-ui-newcomponent/lib/newcomponent/element.rb
module MarkdownUI::NewComponent
  class Element
    def initialize(element, content, klass = nil)
      @element = element
      @content = content
      @klass = klass
    end

    def render
      # Implementation
    end
  end
end
```

2. **Add Renderer Integration**
```ruby
# lib/markdown-ui/renderers/double_emphasis.rb
when /newcomponent/i
  render_newcomponent

def render_newcomponent
  MarkdownUI::NewComponent::Element.new(element, content, klass).render
end
```

3. **Write Comprehensive Tests**
```ruby
# test/newcomponent_test.rb
class NewComponentTest < Test::Unit::TestCase
  def setup
    @parser = MarkdownUI::Parser.new
  end

  def test_basic_newcomponent
    markdown = '__NewComponent|content|options__'
    output = @parser.render(markdown)
    assert_equal expected_html, output
  end
end
```

This completes the comprehensive API reference for Markdown UI. All working components are documented with examples, parameters, and usage patterns.