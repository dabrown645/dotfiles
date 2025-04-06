# Function to display color codes for use to do manual color codes
colors() {
  local fgc bgc vals seq0
  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
  for fgc in {30..37}; do
    for bgc in {40..47}; do
      fgc=${fgc#37}
      bgc=${bgc#40}
      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}
      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo
    echo
  done
}
