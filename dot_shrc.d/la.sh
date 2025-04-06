# Run ls -A if we can (-A is not POSIX), ls -a otherwise
# Override this because aliasing to eza and no longer need
# la() {
  # Prefer --almost-all (exclude "." and "..") if available
  # if [ -e "$HOME"/.cache/sh/opt/ls/almost-all ]; then
    # set -- -A "$@"
  # else
    # set -- -a "$@"
  # fi
  # ls "$@"
# }
