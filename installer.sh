#!/usr/bin/env bash

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

# get from https://gist.github.com/davejamesmiller/1965569
ask() 
{
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
    read -p "$1 [$prompt] " REPLY </dev/tty

    # Default?
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

sublime_package_manager_install()
{
  if ! ask "The sublime package manager is installed on the PC?", N; then
    fail "You should install sublime package manager. See https://packagecontrol.io/installation"
  fi 
}

sublime_config_install()
{
  printf "%s\n" "Sublime-config installing..."

  mkdir -p ~/.settings && cd ~/.settings
  
  if [ ! -d 'sublime-config' ]
  then
    git clone https://github.com/mr-dxdy/sublime-config.git
  fi
  
  cd ~/.config/sublime-text/Packages/ && mv User UserOld
  ln -s ~/.settings/sublime-config/User

  printf "%s\n" "Sublime-config installed."
}

main_install()
{
  sublime_package_manager_install
  sublime_config_install
}

main_install
