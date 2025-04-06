# general use
alias ls='eza --icons --group-directories-first'                                                         # ls
alias l='eza -lbF --git --icons --group-directories-first'                                               # list, size, type, git
alias ll='eza -lbGF --git --icons --group-directories-first'                                             # long list
alias llm='eza -lbGd --git --sort=modified --icons --group-directories-first'                            # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons --group-directories-first'  # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons --group-directories-first' # all + extended list

# specialty views
alias lS='eza -1 --icons --group-directories-first' # one column, just names
alias lt='eza --tree --level=2 --icons'             # tree
alias tree='lt'
