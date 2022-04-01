move::
    1. key word hyperlink: Ctrl+] and Ctrl+T
function::
    1. definition syntax
       :fu[nction][!] {name}([arguments]) [range] [abort] [dict] [closure]
       function, vim key word
       !, force redefine funtion with the same name as a existed function
       {name}, first char must be caplitalized
       [arguments], conveyed as a pointer-like way

buffers::
files::
    list buffers/files by
        :buffers
        :files

    close a specified file
        bd 4

autoread::
udpate::
dynamic::
    update file automatically by
        Autoread

Tricks::
  command-line window:
    q:(in normal mode) to open it
  convert matched word into upper-case ones:
    %s/iptables/\U&/g
  copy current command:
    :let hits=GetMatches(654,723,'shift',1,1)  
    ":p
  delete matched lines
    :g/^ *$/d
    :g!/^ *$/d  or :v/^ *$/d
    :v/error\|varn\|fail/d
  execute current yanked command:
    :@"
  search current word or character
    :yw
    /<C-R><C-R>"
    :yl
  search case sensitive
    /\Cpi
  search ignore case
    /\cpi
  one-line multiple replacement
    call feedkeys(repeat("yn",5))|s/\$/\\>\$/gc
  scrolling synchronously:
    set scb (in each window)
    set scb! (toggle on/off)
  vertical to horizontal or vice versa:
    Ctrl-w t Ctrl-w H  (h->v)
      t, make first top left, H 
      H, make current to full-height at far left
    Ctrl-w t Ctrl-w K (v-h)
      K, make current to full-width at the very top
   change width and height of current window
      :res +5 
      :res -5
      :vertical resize +5

Spellcheck::
  set spelllang=en
  set spell "to start spell
  ]s "jump to next misspelled word
  z= "see suggestions
  zg "add misspelled word under cursor to your personal spellfile, maybe ~/.vim/spell/en.utf-8.add
  zG "ignore the misspelled word under cursor for this ssesion
  zw "to mark correctly spelled word under cursor as a misspeeling
regular::
zero::
count::
find::
regular::
replace::
    *   any number
    \+  one or more
    \w  [a-zA-z]
    example:
        /^ *local\+      "matching leading local
        :%/^ \+[0-9]\+//] "replace leading numbers

Special characters::
    code of current character,
        ga  " ascii
        g8  " utf8
    enter by code,
        <C+v> 64    "@
        <C+v> u64   "d
        <C+k> <c1><c2>
        <C+k> 12  " ½
        @
    digital graphs,
        :digraphs  " check codes
        <C+k> 12   " enter by digital graphs
        
Syntastic::
    do no show flake8 quick fix let g:flake8_show_quickfix=0
    then recheck by press <F7> or call 
        call flake8#Flake8()
word separator::
    temporarily allow - as a in word for * check word by,
        set iskeyword=+-
    yw
    yl
      
help::
helptags::
tags::
    helptags ~/.vim/bundle/vim-latex/doc/
display::
list::
    display line end character "$" and so on
        set list
count::
    characters,
        :%s/./&//gn  
    words,
        :%s/\i\+/&/gn
    lines,
        :%s/^//n
    pattern,
        :%s/pattern/&/gn  
    pattern as a word,
        :%s/\<the\>/&/gn
quantifier::
zero::
more::
one::
n::
    zero or more, as few as possible,
        \{-}
    one or more
        \{-n,m}
    at least n or more
        \{-n,}
    one or at most m
        \{-,m}

plugin::
    list loaded scripts
        :scriptnames

c/c++ plugin::
    NERDTree
    Tlist
    GitGutter
    Ack(should first install ag by apt-get install silversearch-ag)
    omni completion
    echofunc

omni configuration:
    + tags
        mkdir ~/.vim/tags
        download stdlibc++ ctags, and unzip into ~/.vim/tags
        cd ~/.vim/tags
        ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f cpp cpp_src
        ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f gl /usr/include/GL/   # for OpenGL
        ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f sdl /usr/include/SDL/ # for SDL
        ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f linuxheader /usr/include/linux/ # Linux header
        ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f qt5 /opt/Qt/5.15.2/gcc_64/include/ # Qt

    + vimrc configuration 
         au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
         set tags+=~/.vim/tags/cpp
         set tags+=~/.vim/tags/gl
         set tags+=~/.vim/tags/linuxheader
         let OmniCpp_NamespaceSearch = 1
         let OmniCpp_GlobalScopeSearch = 1
         let OmniCpp_ShowAccess = 1
         let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
         let OmniCpp_MayCompleteDot = 1 " autocomplete after .
         let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
         let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
         let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
         "automatically open and close the popup menu / preview window
         au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
         set completeopt=menuone,menu,longest,preview
        " <C-N> <C-P> navigate
        " <C-X><C-O> manually open omnicompletion
        "---------------clang-complete------------"
        "let g:clang_library_path='/usr/lib/llvm-3.9/lib'
        "let g:clang_library_path='/usr/lib/llvm-3.9/lib/libclang-3.9.so.1'
        ":messages after startup could shou something useful
        "<C-X C-U>"
    +   build tags of your own project with Ctrl-F12
        map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

taglist:: source code brower
    + dependence on ctags, install it by 
        sudo apt-get install exuberant-ctags
    + dependence on file type in .vimrc
        filetype on
    + vimrc general tags configuration
        set tags+=~/.vim/tags/cpp
        set tags+=~/.vim/tags/gl
        set tags+=~/.vim/tags/linuxheader
        set tags+=./.tags
    + vimrc configration
        let Tlist_Auto_Open = 1
        let Tlist_Auto_Update = 1
        let Tlist_Close_On_Select = 1
        let Tlist_Compact_Format = 1
        let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'  "only necessary if it is not included in PATH
        let Tlist_Display_Prototype = 1
        let Tlist_Exist_OnlyWindow = 1
        let Tlist_File_Fold_Auto_Close = 1
    + commands
        :TlistOpen
        :TlistToggle

    + current tag, type P on current tag
    
    + toggle, in normal 
        map <silent> <F10> :TlistToggle<CR>

echofunc::
    Alt _ Alt= to scroll
