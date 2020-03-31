[![Join the chat at https://gitter.im/jjuliano/markdown-ui](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jjuliano/markdown-ui?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Code Climate](https://codeclimate.com/github/jjuliano/markdown-ui/badges/gpa.svg)](https://codeclimate.com/github/jjuliano/markdown-ui) [![Build Status](https://travis-ci.org/jjuliano/markdown-ui.svg)](https://travis-ci.org/jjuliano/markdown-ui) [![Test Coverage](https://codeclimate.com/github/jjuliano/markdown-ui/badges/coverage.svg)](https://codeclimate.com/github/jjuliano/markdown-ui/coverage) [![Gem Version](https://badge.fury.io/rb/markdown-ui.svg)](http://badge.fury.io/rb/markdown-ui)

# Markdown UI

Write UI in Markdown Syntax. See http://jjuliano.github.io/markdown-ui/

This is a fork of the original Markdown UI project originally started by Joel Bryan Juliano. A huge amount of gratitude goes out to him for starting this project. This fork will continue to be actively maintained separately.

# Installation

Markdown-UI is readily available as a Ruby gem.
The minimum required Ruby version is 2.0.

`$ gem install markdown-ui`

# Usage

Output is via standard out, which can be piped to create an HTML file. (Under Mac and Linux)

`$ markdown-ui index.mdui > index.html`

# Markdown-UI (Read-Evaluate-Print-Loop) REPL shell

You can interactively create Markdown-UI websites using the markdown-ui-shell.

```
$ markdown-ui-shell

Hit RETURN three times to parse.
# __Button|A Button__
#
#

<button class="ui button">A Button</button>

#
```

# Credits

Markdown-UI would not be possible without the the [Semantic-UI](http：//www.semantic-ui.com) framework, and the Ruby [RedCarpet](https：//github.com/vmg/redcarpet) library. A huge thanks and credit goes to the people behind these wonderful framework and libraries.

# Notes/Issues/Bugs

  * Ongoing support for Semantic-UI elements/modules/components
  * The Colon (:) character will be parsed when used inside a text, needs post-processing to dislay correctly (for URLs)
  * A separator in between two spaces is required on block elements to separate elements (see Column example)
  * Some elements requires custom javascripts (ie toggle button) in order to display and format them properly. You can write in HTML and Javascripts the additional code alongside your Markdown-UI docs to display them properly.

## Contributing

1. Fork it ( https://github.com/jjuliano/markdown-ui/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
