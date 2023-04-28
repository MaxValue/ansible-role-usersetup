PROMPT="%D{%H:%M:%S} $PROMPT"
export PATH=$HOME/bin:$PATH
bcd() {if [ -e "$1" ]; then cd "$(dirname $1)"; else cd "$1"; fi}
alias python="python3"
