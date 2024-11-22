# Connect Forth

A game of Connect Four written in Forth.

## Requirements

To build connect-forth, you need `make` and [Preforth](https://github.com/Arkaeriit/preforth).

To run it, you need a Forth environment. The supported ones are [SEForth](https://github.com/Arkaeriit/SEForth) and [Gforth](https://gforth.org/).

## How to play

Players are shown a Connect Four grid, they must write a number corresponding to the column they want to place their token in to play. Player's turn is handled automatically.

## Play environment

### Standalone executable

Running `make` will generate `connect-forth.frt`. Running this file with your Forth interpreter will run the game where you use the numbers 1 to 7 to play.

### In an interactive Forth interpreter

`make` will also generate `c4.frt`. You can copy this file and then paste it in your interactive Forth environment. Then, start the game with the word `c4-start` and play it with `c4-1` to `c4-7`.

### Running it in a Devzat instance

In a [Devzat](https://github.com/quackduck/devzat) instance running the plugin [Devzat Forth](https://github.com/Arkaeriit/devzat_forth), you can play Connect Forth.

![Multiplayer example](https://github.com/Arkaeriit/connect-forth/blob/master/demo-devzat.png?raw=true)

Start by running `make devzat.frt`. This will generate the file `devzat.frt`. Then copy each line of the file into the chatroom. You will then be able to start the game with the command `forth c4-start` and play with `forth c4-1` to `forth c4-7`.

