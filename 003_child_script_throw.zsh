#!/bin/zsh

# set -x

autoload -Uz throw
autoload -Uz catch

{
    source 002_just_throw.zsh
    echo "source ret: $?" # expect != 0, throwing is canceled by source

    zsh 002_just_throw.zsh
    echo "zsh ret: $?" # expect != 0, throwing is not inherited to parent shell

    sudo -i -u root zsh 002_just_throw.zsh
    echo "sudo zsh ret: $?" # expect != 0, throwing is not inherited to parent shell

} always {
    local ret
    if catch '*'; then
        echo "catched error: $CAUGHT"
        ret=1
    else
        echo "no error"
        ret=0
    fi
    echo "whole script finished"
    return $ret
}

