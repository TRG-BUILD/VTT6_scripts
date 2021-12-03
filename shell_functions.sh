# Config
root=/Users/$USER
col_norm='\033[0;32m'
col_impo='\033[1;31m'
col_end='\033[0m'

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