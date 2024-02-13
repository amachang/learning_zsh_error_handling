#!/bin/zsh

a=9999
b=9999
c=9999
d=9999
e=9999
f=9999

echo --- a ---
# normal block doesn't have local scope
{
    a=1
    echo $a
}
echo $a

echo --- b ---
{
    local b=2
    echo $b
}
echo $b

echo --- c ---
# already declared assigned variable is used to check variable
local c
typeset -p c

echo --- d ---
# function block has local scope
function func_1() {
    # global variable
    echo $d # 9999

    # declaring variable is used to declare and global variable, only for following code
    local d

    # local variable
    echo $d # empty
}
func_1
echo $d

echo --- e ---
function func_2() {
    local -r e=1
    echo $e

    # can't change readyonly variable, even if redeclare with -r
    # exit script except for always
    # e=2
    # local -r e
    # typeset -g f
}
func_2
echo $e

echo --- f ---
function func_3() {
    local f=1

    # local variable
    echo $f # 1

    # once declared local variable, couldn't use global variable even if redeclare with -g
    typeset -g f=2

    # global variable
    echo $f # 2
}
func_3
echo $f # 2

echo --- g ---
function fibonacci() {
    local -i n=$1

    if (( n <= 2 )); then
        echo 1
    else
        # all function local variabls are in stack frame, so we can use recursion
        echo $(( $(fibonacci $((n-1))) + $(fibonacci $((n-2))) ))
    fi
}

echo $(fibonacci 10)

echo --- h ---
function func_4() {
    # difference between -i and not

    local -i a=5 b=05
    echo $a # 5
    echo $b # 5
    if [[ $b == $a ]]; then
        echo "equal as integer [[ $b == $a ]]"
    else
        echo "not equal as integer [[ $b != $a ]]"
    fi

    local c=5 d=05
    echo $c # 5
    echo $d # 05
    if [[ $d == $c ]]; then
        echo "equal as string [[ $d == $c ]]"
    else
        echo "not equal as string [[ $d != $c ]]"
    fi
}
func_4

