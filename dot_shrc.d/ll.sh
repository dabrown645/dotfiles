# Run ls -Al if we can (-A is not POSIX), ls -al otherwise
#-# Override this because aliasing to eza and no longer need
#-#ll() {
#-#  # Prefer -A/--almost-all (exclude "." and "..") if available
#-#  if [ -e "$HOME"/.cache/sh/opt/ls/almost-all ]; then
#-#    set -- -Al "$@"
#-#  else
#-#    set -- -al "$@"
#-#  fi
#-#  ls "$@"
#-#}
