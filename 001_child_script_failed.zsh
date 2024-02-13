#!/bin/zsh

# set -x

autoload -Uz throw
autoload -Uz catch

{
    source 000_throw_catch_always.zsh
    echo "source ret: $?" # expect 1

    zsh 000_throw_catch_always.zsh
    echo "zsh ret: $?" # expect 1

    sudo -i -u root zsh 000_throw_catch_always.zsh
    echo "sudo zsh ret: $?" # expect 1

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


