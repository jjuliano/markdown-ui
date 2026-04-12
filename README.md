[![Join the chat at https://gitter.im/jjuliano/markdown-ui](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jjuliano/markdown-ui?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![Code Climate](https://codeclimate.com/github/jjuliano/markdown-ui/badges/gpa.svg)](https://codeclimate.com/github/jjuliano/markdown-ui) [![Build Status](https://travis-ci.org/jjuliano/markdown-ui.svg)](https://travis-ci.org/jjuliano/markdown-ui) [![Test Coverage](https://codeclimate.com/github/jjuliano/markdown-ui/badges/coverage.svg)](https://codeclimate.com/github/jjuliano/markdown-ui/coverage) [![Gem Version](https://badge.fury.io/rb/markdown-ui.svg)](http://badge.fury.io/rb/markdown-ui)

# Markdown UI

**Write responsive web UIs in plain Markdown syntax.**

Markdown-UI translates extended Markdown into fully styled [Fomantic-UI](https://fomantic-ui.com) HTML — buttons, forms, grids, modals, and 60+ other components — with no knowledge of HTML or CSS required.

Project website: <http://jjuliano.github.io/markdown-ui/>

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [CLI Options](#cli-options)
- [Interactive Shell (REPL)](#interactive-shell-repl)
- [Version Configuration](#version-configuration)
- [Local Assets](#local-assets)
- [Supported Components](#supported-components)
- [Syntax Quick Reference](#syntax-quick-reference)
- [Notes / Known Limitations](#notes--known-limitations)
- [Credits](#credits)
- [Contributing](#contributing)

---

## Requirements

- Ruby **3.0** or newer
- Bundler 2.7+

---

## Installation

Install the gem from [RubyGems](https://rubygems.org/gems/markdown-ui):

```bash
gem install markdown-ui
```

---

## Usage

Pass a Markdown file and redirect standard output to produce an HTML file:

```bash
markdown-ui index.md > index.html
```

The generated HTML includes a full `<!DOCTYPE html>` document that loads Fomantic-UI and jQuery from a CDN by default.

### CLI Options

```
Usage: markdown-ui [options] [markdown_file]

If no file is provided, interactive mode is started.

Options:
    -i, --interactive               Start interactive shell mode
        --interactive-html          Generate full HTML in interactive mode
        --local-assets              Use local npm packages instead of CDN
        --fomantic-version VERSION  Specify Fomantic UI version (default: 2.9.3)
        --jquery-version VERSION    Specify jQuery version (default: 3.7.1)
    -h, --help                      Show this help message
    -v, --version                   Show version
```

---

## Interactive Shell (REPL)

Start the built-in read-evaluate-print loop to experiment with Markdown-UI syntax in real time:

```
$ markdown-ui --interactive

MarkdownUI Interactive Shell

Commands:
  - Type markdown and press ENTER three times to parse
  - 'exit', 'quit', or 'bye' to exit
  - 'help' for this message
  - 'clear' to clear the screen
  - 'version' for version information

Start typing your markdown...
markdown> __button|A Button__
#
#

Rendered output:
==================================================
<button class="ui button">A Button</button>
==================================================
```

Add `--interactive-html` to receive a complete HTML document instead of a bare snippet:

```bash
markdown-ui --interactive --interactive-html
```

---

## Version Configuration

Fomantic-UI and jQuery CDN versions can be overridden via environment variables or CLI flags.

**Environment variables** (source `.markdown-ui-versions` for a ready-made template):

```bash
export MARKDOWN_UI_FOMANTIC_VERSION=2.9.3   # default
export MARKDOWN_UI_JQUERY_VERSION=3.7.1     # default
```

**Command-line flags** (take precedence over environment variables):

```bash
markdown-ui --fomantic-version 2.9.3 --jquery-version 3.7.1 index.md > index.html
```

Supported version ranges: Fomantic-UI **2.8.0+**, jQuery **3.6.0+**.

---

## Local Assets

When deploying to an environment without internet access, install Fomantic-UI and jQuery via npm and serve assets locally:

```bash
npm install fomantic-ui jquery
markdown-ui --local-assets index.md > index.html
```

The `--local-assets` flag rewrites all asset references to `/node_modules/…` paths instead of CDN URLs.

---

## Supported Components

See [COMPONENTS.md](COMPONENTS.md) for the full syntax reference. The table below lists every supported component by category.

### Elements

| Component   | Component   | Component   |
|-------------|-------------|-------------|
| Buttons     | Containers  | Dividers    |
| Emojis      | Fields      | Flags       |
| Headers     | Icons       | Images      |
| Inputs      | Labels      | Loaders     |
| Placeholders| Rails       | Reveals     |
| Segments    | Steps       | Text        |

### Collections

| Component   | Component   | Component   |
|-------------|-------------|-------------|
| Breadcrumbs | Forms       | Grids       |
| Menus       | Messages    | Tables      |

### Modules

| Component     | Component   | Component   |
|---------------|-------------|-------------|
| Accordions    | Calendars   | Checkboxes  |
| Dimmers       | Dropdowns   | Embeds      |
| Flyouts       | Modals      | Nags        |
| Popups        | Progress    | Ratings     |
| Search        | Shapes      | Sidebars    |
| Sliders       | Sticky      | Tabs        |
| Toasts        | Transitions |             |

### Views

| Component      | Component | Component  |
|----------------|-----------|------------|
| Advertisements | Cards     | Comments   |
| Feeds          | Items     | Statistics |

### Behaviors

| Behavior   | Behavior | Behavior   |
|------------|----------|------------|
| API        | State    | Visibility |

---

## Syntax Quick Reference

Below are the most common patterns. See [COMPONENTS.md](COMPONENTS.md) for the full list.

### Short-hand (inline) syntax

```markdown
__button|Click Me__
__primary button|Save__
__icon|home__
__label|New__
__input|Enter text__
__segment|Content goes here__
__message|Hello world__
__progress|75__
```

### Block syntax (block-quote nesting)

```markdown
> Container:
> > Grid:
> > > Column:
> > > Content for column one
> > > Column:
> > > Content for column two
```

### Emoji shortcodes

```markdown
:smile:   :heart:   :thumbsup:   :fire:
```

### Menus and navigation

```markdown
> Menu:
> [Home](#)
> [About](#about)
> [Contact](#contact)
> > Right Menu:
> > [Login](#login)
```

---

## Notes / Known Limitations

- **Ongoing component support** — new Fomantic-UI components are added incrementally; check [TODO.md](TODO.md) for status.
- **Colon character** — a bare `:` inside body text is interpreted as a block-element separator; use `&#58;` or a full-width colon `：` for literal colons (e.g. in URLs).
- **Block-element spacing** — a `<!-- -->` comment or a blank line with two spaces is required between sibling block elements (e.g. adjacent columns).
- **JavaScript-dependent components** — some Fomantic-UI components (e.g. toggle buttons, modals, dropdowns) require JavaScript to function. Embed a `<script>` block alongside your Markdown-UI source to initialise them.

---

## Credits

Markdown-UI is built on top of two excellent open-source projects:

- [Fomantic-UI](https://fomantic-ui.com) — the community-maintained fork of Semantic-UI that provides all CSS components and JavaScript behaviours.
- [RedCarpet](https://github.com/vmg/redcarpet) — the fast and flexible Markdown parser that drives the rendering pipeline.

A huge thanks to the contributors behind both projects.

---

## Contributing

1. Fork the repository ( <https://github.com/jjuliano/markdown-ui/fork> )
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Open a Pull Request

Please run the test suite before submitting:

```bash
bundle exec rake test
```
