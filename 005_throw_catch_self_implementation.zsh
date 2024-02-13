#!/bin/zsh

# I learned:
# TRY_BLOCK_ERROR is special meaning if it set to 0, it means errflag will be reset after always block
# https://github.com/zsh-users/zsh/blob/04ae7dc64cde2fa6b7354f685596ff570404a2c9/Src/loop.c#L767

function catch {
    if [[ $TRY_BLOCK_ERROR -gt 0 && $EXCEPTION = ${~1} ]]; then

        (( TRY_BLOCK_ERROR = 0 ))
        typeset -g CAUGHT="$EXCEPTION"
        unset EXCEPTION
        return 0
    fi

    return 1
}

# Never use globbing with "catch".
alias catch="noglob catch"

function throw {
    typeset -g EXCEPTION="$1"
    readonly THROW
    if (( TRY_BLOCK_ERROR == 0 )); then
        (( TRY_BLOCK_ERROR = 1 ))
    fi
    THROW= 2>/dev/null
}


{
    throw Error
} always {
    if catch Error; then
        echo "Caught: $CAUGHT"
    fi
}

echo "if caught, keep going after always"

