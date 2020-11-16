alias ll='ls -lAh'

ip() {
    command ip -c "$@"
}

# colorized iptables output
# source: https://gist.github.com/nega0/1d232622a1fa3dad176869bbfe747602
iptcolor() {
    iptables "$@" --line-numbers -vnL |\
      sed -E 's/^Chain.*$/\x1b[4m&\x1b[0m/' |\
      sed -E 's/^num.*/\x1b[33m&\x1b[0m/' |\
      sed -E '/([^y] )((REJECT|DROP))/s//\1\x1b[31m\3\x1b[0m/' |\
      sed -E '/([^y] )(ACCEPT)/s//\1\x1b[32m\2\x1b[0m/' |\
      sed -E '/([ds]pt[s]?:)([[:digit:]]+(:[[:digit:]]+)?)/s//\1\x1b[33;1m\2\x1b[0m/' |\
      sed -E '/([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}(\/([[:digit:]]){1,3}){0,1}/s//\x1b[36;1m&\x1b[0m/g' |\
      sed -E '/([^n] )(LOGDROP)/s//\1\x1b[33;1m\2\x1b[0m/'|\
      sed -E 's/ LOG /\x1b[36;1m&\x1b[0m/'

      ## Line  4 underlines chain "section titles"
      ## Line  5 makes the column headers yellow
      ## Line  6 highlights REJECT and DROP as red everwhere except chain "section titles"
      ## Line  7 highlights ACCEPT as green
      ## Line  8 highlights port numbers as yellow
      ## Line  9 highlights IP address and CIDR blocks as cyan
      ## Line 10 highlights LOGDROP as yellow everywhere except chain "section titles"
      ## Line 11 highlights LOG everywhere as cyan
}
