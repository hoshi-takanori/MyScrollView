# MyScrollView

NSScrollView replacement which scrolls by manually updating its content,  
instead of changing the content view's frame origin.

It works on Snow Leopard and Lion, with (or without) overlay scrollers.

## Purpose

MyScrollView is suitable for the document whose size is changed dynamically,  
or may be very large and sparse.
I wrote it for my [Life Game](http://itunes.apple.com/us/app/life-game/id490816007?ls=1&mt=12) application.

In contrast, NSScrollView is designed that its document view has the same size  
as the document itself, and it's difficult to change the document size dynamically.

## Usage

1. add MyScrollView.h/.m and MyScroller.h/.m to your project,
2. make your content view to conform to MyScrollContent protocol, and
3. see MyContentView class in the example project for more detail.

## Bugs

- doesn't hide scrollers when the document is smaller than the content view.

## Links

- [github repository](https://github.com/hoshi-takanori/MyScrollView)
