# Markdown UI

[![Gem Version](https://badge.fury.io/rb/markdown-ui.svg)](https://badge.fury.io/rb/markdown-ui)
[![Build Status](https://github.com/jjuliano/markdown-ui/actions/workflows/deploy.yml/badge.svg)](https://github.com/jjuliano/markdown-ui/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.txt)

> Write responsive web UIs in plain Markdown syntax.

Markdown UI is a Ruby gem that translates a simple, readable Markdown-based syntax into fully-styled [Fomantic UI](https://fomantic-ui.com) HTML components. It ships as a command-line tool, an interactive shell, and a browser-based REPL powered by Ruby WebAssembly.

**Project website & docs:** https://jjuliano.github.io/markdown-ui/

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [CLI Usage](#cli-usage)
- [Interactive Shell](#interactive-shell)
- [Online REPL](#online-repl)
- [Syntax Reference](#syntax-reference)
- [Component Catalogue](#component-catalogue)
- [Configuration](#configuration)
- [Known Limitations](#known-limitations)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Markdown-first** – write UI components with the same double-underscore syntax you already know, no HTML required
- **50+ components** – buttons, grids, forms, modals, tables, toasts, accordions, calendars, and much more
- **Fomantic UI powered** – output is clean, semantic HTML styled by the Fomantic UI CSS framework
- **Standalone HTML output** – generate a complete, self-contained HTML file with a single command
- **CDN or local assets** – load Fomantic UI from jsDelivr CDN or your own local npm packages
- **Interactive shell** – type Markdown and see the rendered HTML fragment immediately
- **Browser REPL** – experiment without installing anything via Ruby WebAssembly in the browser

---

## Installation

Requires Ruby **≥ 3.0**.

```bash
gem install markdown-ui
```

Or add to your `Gemfile`:

```ruby
gem 'markdown-ui', '~> 0.2'
```

---

## Quick Start

Create a file `page.md`:

```markdown
__Primary Button|Get Started__

__Success Message|Header:Welcome!,Text:"You are all set."__

> Segment:
> "This is a basic content segment."
```

Render to HTML:

```bash
markdown-ui page.md > page.html
```

Generate a complete standalone page (with `<html>`, `<head>`, Fomantic UI CSS/JS):

```bash
markdown-ui --interactive-html page.md > page.html
```

---

## CLI Usage

```
Usage: markdown-ui [options] [markdown_file]

If no file is provided, interactive shell mode is started.

Options:
  -i, --interactive          Start interactive shell mode
      --interactive-html     Generate a full HTML page instead of a fragment
      --local-assets         Use local npm packages instead of CDN
      --fomantic-version VER Specify Fomantic UI version (default: 2.9.3)
      --jquery-version VER   Specify jQuery version (default: 3.7.1)
  -v, --version              Show version
  -h, --help                 Show this help message
```

### Examples

| Goal | Command |
|------|---------|
| Render a fragment | `markdown-ui page.md > page.html` |
| Render a full HTML page | `markdown-ui --interactive-html page.md > page.html` |
| Use local npm assets | `markdown-ui --local-assets page.md > page.html` |
| Pin Fomantic UI version | `markdown-ui --fomantic-version 2.8.8 page.md > page.html` |
| Pin jQuery version | `markdown-ui --jquery-version 3.6.4 page.md > page.html` |
| Start interactive shell | `markdown-ui` or `markdown-ui -i` |

---

## Interactive Shell

Run `markdown-ui` (or `markdown-ui -i`) to open the interactive shell. Type Markdown and press **Enter three times** to render it.

```
$ markdown-ui

MarkdownUI Interactive Shell

Commands:
  - Type markdown and press ENTER three times to parse
  - 'exit', 'quit', or 'bye' to exit
  - 'help' for this message
  - 'clear' to clear the screen
  - 'version' for version information

Start typing your markdown...

markdown> __Button|Click me__

# 

Rendered output:
==================================================
<button class='ui button'>Click me</button>
==================================================

markdown>
```

Shell commands: `help`, `version`, `clear`, `exit` / `quit` / `bye`.

---

## Online REPL

Try Markdown UI directly in your browser — no installation needed:

**https://jjuliano.github.io/markdown-ui/**

The Online REPL runs the full Ruby gem compiled to WebAssembly, giving you the exact same output you get on the command line.

---

## Syntax Reference

Markdown UI provides two equivalent syntaxes for every component: an **inline** form and a **block-quote** form. Use whichever reads more naturally for your content.

### Inline syntax

```
__[Classes] ComponentType|Value|ID__
```

| Part | Description |
|------|-------------|
| `Classes` | Optional Fomantic UI modifier classes (e.g. `Primary`, `Large`) |
| `ComponentType` | Component name (e.g. `Button`, `Segment`, `Message`) |
| `Value` | Content or named attributes (`Text:…`, `Header:…`, `List:…`) |
| `ID` | Optional HTML `id` attribute |

```markdown
__Button|Click me__
__Primary Button|Save|save-btn__
__Message|Header:Changes in Service,Text:"We updated our privacy policy."__
__List Message|Header:New Features,List:Feature A;Feature B;Feature C__
```

Alternatively, use dot notation to apply classes:

```markdown
__Button.Focusable|Focusable Button__
__Button.Klass|Text:Follow|My ID__
```

### Block-quote syntax

```
> ComponentType:
> Content line 1
> Content line 2
```

```markdown
> Primary Button:
> Save

> Segment:
> "Lorem ipsum dolor sit amet."

> Message:
> __Header|Changes in Service__
> "We updated our privacy policy."
```

### Emoji syntax

Use standard colon-delimited emoji names anywhere in your content:

```markdown
:smile:  :heart:  :thumbs_up:  :fire:  :star:
```

### Separator

When placing multiple block-level elements side-by-side (e.g. inside a grid column), separate them with a blank quoted line:

```markdown
> Vertical Segment:
> "First segment"

" "

> Vertical Segment:
> "Second segment"
```

---

## Component Catalogue

See [COMPONENTS.md](COMPONENTS.md) for a full reference with syntax examples for every component.

### Elements

| Component | Example |
|-----------|---------|
| Button | `__Primary Button|Save__` |
| Container | `__Container|Page content__` |
| Divider | `__Section Divider|Section Break__` |
| Emoji | `:rocket:` |
| Flag | `__Flag|us__` |
| Header | `__Large Header|Welcome__` |
| Icon | `__Large Icon|home__` |
| Image | `__Circular Image|https://example.com/avatar.jpg__` |
| Input | `__Icon Input|Search__` |
| Label | `__Red Label|Error__` |
| List | Standard Markdown list syntax |
| Loader | `__Active Loader|Processing__` |
| Placeholder | `__Placeholder|Loading content__` |
| Rail | `__Rail|Sidebar content__` |
| Reveal | `__Reveal|Hover me__` |
| Segment | `__Raised Segment|Content__` |
| Step | `__Step|Shipping__` |
| Text | `__Muted Text|Secondary info__` |

### Collections

| Component | Example |
|-----------|---------|
| Breadcrumb | `__Large Breadcrumb|Home / Library / Data__` |
| Form | `__Form|Form content__` |
| Field | `__Required Field|Field content__` |
| Grid | `__Two Column Grid|Left|Right__` |
| Menu | `__Vertical Menu|Home|About|Contact__` |
| Message | `__Warning Message|Header:Heads up!,Text:"Please review."__` |
| Table | `__Striped Table|Name|Age|Alice|30__` |

### Views

| Component | Example |
|-----------|---------|
| Advertisement | `__Advertisement|Ad content__` |
| Card | `__Card|Card content__` |
| Comment | `__Comment|Comment text__` |
| Feed | `__Feed|Feed content__` |
| Item | `__Item|Item content__` |
| Statistic | `__Statistic|Value|Label__` |

### Modules

| Component | Example |
|-----------|---------|
| Accordion | `__Styled Accordion|Section|Content__` |
| Calendar | `__Date Picker Calendar|Select Date__` |
| Checkbox | `__Toggle Checkbox|Dark Mode__` |
| Dimmer | `__Dimmer|Overlay text__` |
| Dropdown | `__Selection Dropdown|Choose Item__` |
| Flyout | `__Flyout|Side panel content__` |
| Modal | `__Small Modal|Modal content__` |
| Nag | `__Nag|Cookie notice__` |
| Popup | `__Popup|Tooltip text__` |
| Progress | `__Indicating Progress|60__` |
| Rating | `__Rating|Star__` |
| Search | `__Search|Query__` |
| Shape | `__Shape|Content__` |
| Sidebar | `__Sidebar|Sidebar content__` |
| Slider | `__Slider|50__` |
| Tab | `__Tabular Menu|Page 1|Page 2__` |
| Toast | `__Success Toast|Saved successfully!__` |
| Transition | `__Transition|Animated content__` |
| Visibility | `__Visibility|Content__` |

### Behaviors

| Component | Example |
|-----------|---------|
| API | `__API|/api/users__` |
| State | `__State|active__` |

---

## Configuration

### Environment variables

You can set default Fomantic UI and jQuery versions via environment variables instead of passing CLI flags every time:

```bash
export MARKDOWN_UI_FOMANTIC_VERSION=2.9.3
export MARKDOWN_UI_JQUERY_VERSION=3.7.1
```

A template is provided in [`.markdown-ui-versions`](.markdown-ui-versions). Source it to apply:

```bash
source .markdown-ui-versions
```

### Local npm assets

Instead of loading Fomantic UI and jQuery from CDN, you can serve them locally. Install the packages first:

```bash
npm install fomantic-ui jquery
```

Then pass `--local-assets`:

```bash
markdown-ui --local-assets page.md > page.html
```

Assets are resolved from `/node_modules/` at the document root.

---

## Known Limitations

- **Colon (`:`) in text** – colons inside text content are partially consumed by the parser; URLs in plain text require pre/post-processing workarounds.
- **Block-element separators** – a blank `" "` separator line is required between adjacent block-level elements inside containers (e.g. columns).
- **Toggle button / interactive modules** – some Fomantic UI modules (e.g. toggle button, sidebar) require additional JavaScript. You can embed raw HTML and `<script>` blocks directly alongside your Markdown UI source.
- **Supported Fomantic UI versions** – 2.8.0 and above.
- **Supported jQuery versions** – 3.6.0 and above.

---

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jjuliano/markdown-ui.

1. Fork it ( https://github.com/jjuliano/markdown-ui/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

---

## License

Released under the [MIT License](LICENSE.txt). Copyright © 2015 Joel Bryan Juliano.
