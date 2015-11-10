> Container:
> > Inverted Segment:
> > > Stackable Inverted Container Menu:
> > > [Markdown UI](http：//jjuliano.github.io/markdown-ui "active basic")
> > > > Stackable Inverted Right Menu:
> > > > [Docs](docs/toc.html)
> > > > [About](about.html)
> > > > [Github](https：//github.com/jjuliano/markdown-ui)
> > > > [Install](#install)
>
> <!-- -->
> > Inverted Attached Basic Blue Very Padded Segment:
> > # Markdown UI
> > ### Responsive UI in Markdown
> > [__Button|Get Started__](docs/toc.html)
>
> <!-- -->
> > Basic Attached Segment:
> > > Stackable Equal Width Grid:
> > > > Column:
> > > > ## Installation::install
> > > > Markdown-UI is readily available as a Ruby gem. The minimum required Ruby version is 2.0. <br /> <br />
> > > > ```gem install markdown-ui```
> > > >
> > > > ## Usage::usage
> > > > Output is via standard out, which can be piped to create an HTML file. (Under Mac and Linux) <br /> <br />
> > > > ```markdown-ui index.mdui > index.html```
> > > >
> > > > ## Markdown-UI (Read-Evaluate-Print-Loop) REPL shell
> > > > You can interactively create Markdown-UI websites using the `markdown-ui-shell`.
> > > > > Message:
> > > > > ```$ markdown-ui-shell``` <br />
> > > > > ``` ``` <br />
> > > > > ```Hit RETURN three times to parse.``` <br />
> > > > > ```# __Button|A Button__``` <br />
> > > > > ```# ``` <br />
> > > > > ```# ``` <br />
> > > > > ``` ``` <br />
> > > > > ```    <button class="ui button">A Button</button>``` <br />
> > > > > ``` ``` <br />
> > > > > ```# ```
> > > >
> > > > ## Credits::credits
> > > > Markdown-UI would not be possible without the the [Semantic-UI](http：//www.semantic-ui.com) framework, and the Ruby [RedCarpet](https：//github.com/vmg/redcarpet) library. A huge thanks and credit goes to the people behind these wonderful framework and libraries.
> > > >
> > > > ## Source
> > > > This document is written entirely in Markdown-UI. see： [the source files](https：//github.com/jjuliano/markdown-ui/tree/master/website)
> > > >
> > > > ## Notes/Issues/Bugs::issues-bugs
> > > >
> > > > * Ongoing support for Semantic-UI elements/modules/components
> > > > * The Colon (：) character will be parsed when used inside a text, needs post-processing to dislay correctly (for URL's)"
> > > > * A separator in between two spaces is required on block elements to separate elements (see Column example)
> > > > * Some elements requires custom javascripts (ie toggle button) in order to display and format them properly. You can write in HTML and Javascripts the additional code alongside your Markdown-UI docs to display them properly.
> > > >
> > >
> > > <!-- -->
> > > > Column:
> > > > > Inverted Very Padded Segment:
> > > > > ```> Pointing Menu：``` <br />
> > > > > ```> [Home](#root "active")``` <br />
> > > > > ```> [Messages](#messages)``` <br />
> > > > > ```> [Friends](#friends)``` <br />
> > > > > ```> > Right Menu：``` <br />
> > > > > ```> > [Logout](#logout)``` <br />
> > > > > <br />
> > > > > ```__Button|Add Friend__```
>
> <!-- -->
> ##Cheat Sheet:Center Aligned:cheatsheets
> > Stackable Equal Width Grid:
> > > Column:
> > > > Basic Segment:
> > > > ##### Button
> > > > > Inverted Blue Segment:
> > > > > ``` # Short-Hand ``` <br />
> > > > > ``` __Button|Button Text__ ```
> > > >
> > > > <!-- -->
> > > > > Inverted Blue Segment:
> > > > > ``` # Block Syntax ``` <br />
> > > > > ``` > Button： ``` <br />
> > > > > ``` > Button Text ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Container
> > > > > Inverted Blue Segment:
> > > > > ``` > Container： ``` <br />
> > > > > ``` > ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Icon
> > > > > Inverted Blue Segment:
> > > > > ``` _Icon <Name>_ ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Segment
> > > > > Inverted Blue Segment:
> > > > > ``` > Segment： ``` <br />
> > > > > ``` > ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Menu
> > > > > Inverted Blue Segment:
> > > > > ``` > Menu： ``` <br />
> > > > > ``` > [Menu Item]() ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### List
> > > > > Inverted Blue Segment:
> > > > > ``` # Unordered List ``` <br />
> > > > > ``` * List 1 ``` <br />
> > > > > ``` * List 2 ``` <br />
> > > > > ``` # Ordered List ``` <br />
> > > > > ``` 1. List 1 ``` <br />
> > > > > ``` 1. List 2 ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Label
> > > > > Inverted Blue Segment:
> > > > > ``` > Label： ``` <br />
> > > > > ``` > _Mail Icon_ 23 ``` <br />
> >
> > <!-- -->
> > > Column:
> > > > Basic Segment:
> > > > ##### Item
> > > > > Inverted Blue Segment:
> > > > > ``` [Item](#URL_ID "class") ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Message
> > > > > Inverted Blue Segment:
> > > > > ``` # Short-Hand ``` <br />
> > > > > ``` __Message|Header：Message Header,Text：Message Text__ ``` <br />
> > > >
> > > > <!-- -->
> > > > > Inverted Blue Segment:
> > > > > ``` # Block Syntax ``` <br />
> > > > > ``` > Message： ``` <br />
> > > > > ``` > __Header|Message Header__ ``` <br />
> > > > > ``` > Message Text ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Header
> > > > > Inverted Blue Segment:
> > > > > ``` # H1, ## H2, ### H3, #### H4 ... ``` <br />
> > > >
> > > > <!-- -->
> > > > > Inverted Blue Segment:
> > > > > ``` # DIV tag header ``` <br />
> > > > > ``` __Header|A Div Header__ ``` <br />
> > > >
> > > > <!-- -->
> > > > ##### Column / Grid / Row / Segment / Container
> > > > > Inverted Blue Segment:
> > > > > ``` > Grid：``` <br />
> > > > > ``` > ``` <br />
> > > > > ``` > <!-- -->``` <br />
> > > > > ``` > ``` <br />
> > > > > ``` > > Column：``` <br />
> > > > > ``` > > Column 1 ``` <br />
> > > > > ``` > ``` <br />
> > > > > ``` > <!-- -->``` <br />
> > > > > ``` > ``` <br />
> > > > > ``` > > Column：``` <br />
> > > > > ``` > > Column 2 ``` <br />
