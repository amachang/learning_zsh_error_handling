#!/bin/zsh

set -x

autoload -Uz throw
autoload -Uz catch

function failed_function() {
    {
        echo 'failed_function started'
        return 1
        echo 'never reached this line'
    } always {
        echo 'failed_function finished'
    }
}

{
    # failed but no error thrown
    failed_function

    # failed and error thrown
    failed_function || throw Error

    echo "never reached this line"
} always {
    if catch '*'; then
        echo "catched error: $CAUGHT"
        typeset ret=1
    else
        echo "no error"
        typeset ret=2
    fi
}

# if error catched, continue after always block
echo "done: $ret"
return $ret

