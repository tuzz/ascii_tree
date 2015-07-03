## Ascii Tree

[![Build Status](https://travis-ci.org/tuzz/ascii_tree.svg?branch=master)](https://travis-ci.org/tuzz/ascii_tree)

Parses a usable tree from ASCII art.

Ascii Tree turns something humans understand into something computers
understand. It is an expressive and efficient way to define trees.

## Usage

```ruby
root = AsciiTree.parse('

      # Christmas themed tree:

              chestnuts
              /     |  \
          roasting  on  an
            /   \         \
        open   fire       jack
               /   \
            frost  nipping
                    /  |  \
                  on  your nose   # Ouch!

')

root.id
#=> "chestnuts"

root.parent
#=> nil

root.children
#=> [#<AsciiTree::Node @id="roasting">, ...]
```

## Multiple words

Use parenthesis to group words into a single node:

```ruby
root = AsciiTree.parse('

          (     single node     )
              /    |    |    |   \
    (so is this)  but these are separate

')

root.id
#=> "single node"
```

## Values

You can set arbitrary values on nodes:

```ruby
root = AsciiTree.parse('

        root{123}
         /    \
     a{"foo"}  b
       / \
      c   d{[1,2,3].reverse}

')

root.value
#=> 123
```

## Contribution

If you'd like to contribute, please open an issue or submit a pull request.
