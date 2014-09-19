Vim for Mac
============

This is my *personal* vim bundle mainly for Mac, but it should also work on Linux/Unix with a little tweaks.


Prerequisites
=============


* Updated Vim Version
* Build Tools Supports

    brew install cmake ctags
    brew install macvim --with-cscope --with-lua
    brew install vim --with-lua --override-system-vim
    brew linkapps

[Issues with MacVim](https://github.com/b4winckler/macvim/wiki/Troubleshooting)


Install
=======

Run the following line from your terminal

    curl https://raw.githubusercontent.com/jimzhan/dotvim/master/setup -L -o - | sh


Preview
=======

![Vim with NERDTree + Tagbar Opened](preview/dotvim.png)



Plugins
=======

### Plugins Manager

* [Shougo/neobundle](https://github.com/Shougo/neobundle.vim): based on [gmarik/vundle](https://github.com/gmarik/vundle) but way better with tons of added features.


### File Manager

* [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree): IDE-liked file manager.

```bash
map <C-o>   <plug>NERDTreeTabsToggle<CR>
```

* [kien/ctrlp](https://github.com/kien/ctrlp.vim): fuzzy file finder.


### GIT

* [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive): the best GIT plugin for Vim with shortcuts.

```bash
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
```

### Autocomplete

* [Shougo/neocomplete](https://github.com/Shougo/neocomplete.vim) + [Shougo/neosnippet](https://github.com/Shougo/neosnippet.vim): lightweight (especially comparing to [YCM](https://github.com/Valloric/YouCompleteMe), compiled size: 175MB on my laptop...) yet powerful. (Required Vim with lua compiled)


### File Editing

* [scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter): help commenting/uncommenting blocks in document.
* [jiangmiao/auto-pairs](https://github.com/jiangmiao/auto-pairs): insert or delete brackets, parens, quotes in pair.
* [terryma/vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors): multiple selection & editing like Sublime Text.
* [aperezdc/vim-template](https://github.com/aperezdc/vim-template): allows you to have a set of templates for certain file types.


### File Types

* [tpope/vim-markdown](https://github.com/tpope/vim-markdown): Markdown
* [fatih/vim-go](https://github.com/fatih/vim-go): Golang support for Vim that comes with pre-defined sensible settings.


### Programming

* [mattn/emmet-vim](https://github.com/mattn/emmet-vim): previously known as Zen Coding, improve HTML/CSS workflow by combining shortcuts & snippets.
* [majutsushi/tagbar](https://github.com/majutsushi/tagbar): provides a sidebar that displays the ctags-generated tags of the current file, ordered by their scope.
* [scrooloose/syntastic](https://github.com/scrooloose/syntastic): syntax checking that runs files through external syntax checkers and displays any resulting errors to the user.


### Status Bar

* [bling/vim-airline](https://github.com/bling/vim-airline): Status line enhancements with buffers listing enabled.


### Color Scheme

* [tomasr/molokai](https://github.com/tomasr/molokai): by far, this is simply the best color scheme I've ever tested that works beautifully on both iTerms & Gvim right out of the box.



Key Mappings
============
* *jj*  as \<ESC\>
* *,*   as \<Leader\>
