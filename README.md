[![Join the chat at https://gitter.im/jjuliano/markdown-ui](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jjuliano/markdown-ui?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Code Climate](https://codeclimate.com/github/jjuliano/markdown-ui/badges/gpa.svg)](https://codeclimate.com/github/jjuliano/markdown-ui) [![Build Status](https://github.com/jjuliano/markdown-ui/actions/workflows/deploy.yml/badge.svg)](https://github.com/jjuliano/markdown-ui/actions) [![Test Coverage](https://codeclimate.com/github/jjuliano/markdown-ui/badges/coverage.svg)](https://codeclimate.com/github/jjuliano/markdown-ui/coverage) [![Gem Version](https://badge.fury.io/rb/markdown-ui.svg)](http://badge.fury.io/rb/markdown-ui)

# Markdown UI

Write UI in Markdown Syntax. See http://jjuliano.github.io/markdown-ui/

# Installation

Markdown-UI is readily available as a Ruby gem.
The minimum required Ruby version is 3.0.

`$ gem install markdown-ui`

# Usage

Output is via standard out, which can be piped to create an HTML file. (Under Mac and Linux)

`$ markdown-ui index.mdui > index.html`

Generate a complete standalone HTML page:

`$ markdown-ui --interactive-html index.mdui > index.html`

Use local assets instead of CDN:

`$ markdown-ui --local-assets index.mdui > index.html`

Specify Fomantic UI or jQuery versions:

`$ markdown-ui --fomantic-version 2.9.3 --jquery-version 3.7.1 index.mdui > index.html`

Run `markdown-ui --help` for the full list of options.

# Markdown-UI Interactive Shell (REPL)

You can interactively create Markdown-UI content by running `markdown-ui` with no arguments or with the `-i` flag.

```
$ markdown-ui -i

MarkdownUI Interactive Shell v0.2.0
Type 'help' for available commands or 'exit' to quit.
Type 'version' for version information

Start typing your markdown...

markdown> __Button|A Button__


<button class="ui button">A Button</button>

markdown>
```

# Online REPL (Browser-based)

You can try Markdown-UI directly in your browser using the Online REPL powered by Ruby WebAssembly:

https://jjuliano.github.io/markdown-ui/

# Components

Markdown-UI supports a wide range of [Fomantic UI](https://fomantic-ui.com) components, including:

**Elements:** Button, Container, Divider, Emoji, Flag, Header, Icon, Image, Input, Label, List, Loader, Placeholder, Rail, Reveal, Segment, Step

**Collections:** Breadcrumb, Form, Grid, Menu, Message, Table

**Views:** Advertisement, Card, Comment, Feed, Item, Statistic

**Modules:** Accordion, Calendar, Checkbox, Dimmer, Dropdown, Flyout, Modal, Nag, Popup, Progress, Rating, Search, Shape, Sidebar, Slider, Tab, Toast, Transition, Visibility

**Behaviors:** API, State

See [COMPONENTS.md](COMPONENTS.md) for a comprehensive reference with syntax examples for every component.

# Credits

Markdown-UI would not be possible without the [Fomantic UI](https://fomantic-ui.com) framework and the Ruby [RedCarpet](https://github.com/vmg/redcarpet) library. A huge thanks and credit goes to the people behind these wonderful frameworks and libraries.

# Notes/Issues/Bugs

  * Ongoing support for Fomantic UI elements/modules/components
  * The Colon (:) character will be parsed when used inside a text, needs post-processing to display correctly (for URLs)
  * A separator in between two spaces is required on block elements to separate elements (see Column example)
  * Some elements require custom JavaScript (e.g. toggle button) in order to display and format them properly. You can write HTML and JavaScript alongside your Markdown-UI docs to handle these cases.

## Contributing

1. Fork it ( https://github.com/jjuliano/markdown-ui/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
