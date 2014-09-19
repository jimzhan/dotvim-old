Vim for Mac
============

This is my *personal* vim bundle mainly for Mac, but it should also work on Linux/Unix with a little tweaks.


## Prerequisites
    * Updated Vim Version
    * Build Tools Supports

        brew install cmake ctags
        brew install macvim --with-cscope --with-lua
        brew install vim --with-lua --override-system-vim
        brew linkapps

[Issues with MacVim](https://github.com/b4winckler/macvim/wiki/Troubleshooting)


## Install

Run the following line from your terminal

    curl https://raw.githubusercontent.com/jimzhan/dotvim/master/setup -L -o - | sh


## Preview

![Vim with NERDTree + Tagbar Opened](preview/dotvim.png)


## Notes

### Autocomplete


#### NeoComplete

#### YCM (aka. YouCompleteMe)
    install.sh --clang-completer
