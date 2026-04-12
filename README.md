[![Join the chat at https://gitter.im/jjuliano/markdown-ui](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jjuliano/markdown-ui?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Code Climate](https://codeclimate.com/github/jjuliano/markdown-ui/badges/gpa.svg)](https://codeclimate.com/github/jjuliano/markdown-ui) [![Build Status](https://travis-ci.org/jjuliano/markdown-ui.svg)](https://travis-ci.org/jjuliano/markdown-ui) [![Test Coverage](https://codeclimate.com/github/jjuliano/markdown-ui/badges/coverage.svg)](https://codeclimate.com/github/jjuliano/markdown-ui/coverage) [![Gem Version](https://badge.fury.io/rb/markdown-ui.svg)](http://badge.fury.io/rb/markdown-ui)

# Markdown UI

Write UI in Markdown Syntax. See http://jjuliano.github.io/markdown-ui/

# Installation

Markdown-UI is readily available as a Ruby gem.
The minimum required Ruby version is 2.0.

`$ gem install markdown-ui`

# Usage

Output is via standard out, which can be piped to create an HTML file. (Under Mac and Linux)

`$ markdown-ui index.mdui > index.html`

### Options

```
Usage: markdown-ui [options] [markdown_file]

If no file is provided, interactive mode is started.

Options:
    -i, --interactive            Start interactive shell mode
        --interactive-html       Generate full HTML in interactive mode
        --local-assets           Use local npm packages instead of CDN
        --fomantic-version VERSION  Specify Fomantic UI version (default: 2.9.3)
        --jquery-version VERSION    Specify jQuery version (default: 3.7.1)
    -h, --help                   Show this help message
    -v, --version                Show version
```

# Markdown-UI (Read-Evaluate-Print-Loop) REPL shell

You can interactively create Markdown-UI websites using the built-in interactive shell.

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

# Version Configuration

You can customise the Fomantic UI and jQuery CDN versions used in generated HTML either via command-line options or environment variables. A `.markdown-ui-versions` file is provided in the repository as a reference:

```bash
# Fomantic UI version (default: 2.9.3)
export MARKDOWN_UI_FOMANTIC_VERSION=2.9.3

# jQuery version (default: 3.7.1)
export MARKDOWN_UI_JQUERY_VERSION=3.7.1
```

Or pass them directly on the command line:

```
$ markdown-ui --fomantic-version 2.9.3 --jquery-version 3.7.1 index.md > index.html
```

# Supported Components

See [COMPONENTS.md](COMPONENTS.md) for a full reference of all supported UI components and their syntax.

### Elements
Buttons, Containers, Dividers, Emojis, Fields, Flags, Icons, Images, Inputs, Labels, Loaders, Placeholders, Rails, Reveals, Segments, Steps, Text

### Collections
Breadcrumbs, Forms, Grids, Menus, Messages, Tables

### Modules
Accordions, Calendars, Checkboxes, Dimmers, Dropdowns, Embeds, Flyouts, Modals, Nags, Popups, Progress Bars, Ratings, Search, Shapes, Sidebars, Sliders, Sticky, Tabs, Toasts, Transitions

### Views
Advertisements, Cards, Comments, Feeds, Items, Statistics

### Behaviors
API, State, Visibility

# Credits

Markdown-UI would not be possible without the [Fomantic-UI](https://fomantic-ui.com) framework (the community fork of Semantic-UI), and the Ruby [RedCarpet](https://github.com/vmg/redcarpet) library. A huge thanks and credit goes to the people behind these wonderful frameworks and libraries.

# Notes/Issues/Bugs

  * Ongoing support for Fomantic-UI elements/modules/components
  * The Colon (:) character will be parsed when used inside a text, needs post-processing to display correctly (for URLs)
  * A separator in between two spaces is required on block elements to separate elements (see Column example)
  * Some elements require custom JavaScript (e.g. toggle button) in order to display and format them properly. You can write HTML and JavaScript alongside your Markdown-UI docs to handle these cases.

## Contributing

1. Fork it ( https://github.com/jjuliano/markdown-ui/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
