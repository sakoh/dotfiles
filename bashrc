# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export Editor=vim
export Broswer=/usr/bin/firefox
export RADV_PERFTEST=aco
