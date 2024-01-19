# Config

environment_name="build2024"
root=$HOME
col_norm='\033[0;32m'
col_impo='\033[1;31m'
col_end='\033[0m'

cols=$(tput cols)
lines=$(tput lines)
echo $cols
echo $lines

test=$(basename "/bin/zsh" );
 
shellrc="${HOME}/.${test}rc";

echo $shellrc
                  

# helper functions
p_n() {
    echo "$col_norm$1$col_end"
}

p_i() {
    echo "$col_impo$1$col_end"
}
p_s() {
    echo ""
}
