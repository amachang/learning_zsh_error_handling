#!/bin/zsh

set -x

(( 1 )); echo "(( 1 )); \$? = $?"
(( 0 )); echo "(( 0 )); \$? = $?"

# if using (( )) in [[ ]] just ignored (( )) in syntax
# [[ (( a == 1 )) ]] is syntactically equal to [[ 'a' == '1' ]]

# $(( )) is used for expansion, not evaluation. the expression bellow is expanded 1 and literal 1 is compared as string
[[ $(( 1 )) == 1 ]]; echo "[[ \$(( 1 )) == 1 ]]; \$? = $?"

# (( )) is used for evaluation, so 1 is compared to 1 as integer
(( 1 == 1 )); echo "(( 1 == 1 )); \$? = $?"
(( $(( 1 )) == 1 )); echo "(( \$(( 1 )) == 1 )); \$? = $?"

# (( )) in (( )) is used for just ( )'s arithmetic operation twice
# (( (( 5 )) == 5 )) is equal to (( 5 == 5 ))
(( (( 5 )) == 5 )); echo "(( (( 5 )) == 5 )); \$? = $?"

# single value in [[ ]] is treated as string length evaluation
# so, below is equal to [[ -n "0" ]] and it's true
[[ 0 ]]; echo "[[ 0 ]]; \$? = $?"

# even if the variable is integer, it's treated as string length evaluation
local -i a=100
[[ $a ]]; echo "[[ \$a ]]; \$? = $?"

# as the same as above, if left and right hand side expressions are single value, it's treated as string length evaluation
[[ 0 && 0 ]]; echo "[[ 0 && 0 ]]; \$? = $?"

