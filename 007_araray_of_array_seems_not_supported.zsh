#!/bin/zsh

# Error occurred when using array of array like below

local -A a=(
    "a" (1 2 3)
    "c" "d"
    "e" "f"
)

local -a b=(
    (1 2 3) (4 5 6)
)

for k v in ${(@kv)a}; do
    echo "$k": "$v"
done


