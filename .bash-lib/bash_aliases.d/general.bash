
# General useful stuff

alias h='history'
alias j='jobs -l'
# show each item of $PATH on new line
alias path='echo -e ${PATH//:/\\n}'
# show open ports
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ports='netstat -tulanp'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ports='lsof -n -i4TCP'
fi

