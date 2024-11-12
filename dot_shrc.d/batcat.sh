# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping bc(1) with a function at all
[ -d "$HOME"/.cache/sh/opt/batcat ] || return

# Define function proper
bat() {

  if type -p batcat; then
    cmd=batcat
  elif type -p bat; then
    cmd=bat
  fi

  if [ -e "$HOME"/.cache/sh/opt/batcat/number ]; then
    set -- --number "$@"
  fi

  # Run bc(1) with the concluded arguments
  command ${cmd} "$@"
}
