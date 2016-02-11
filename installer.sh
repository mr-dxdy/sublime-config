#!/usr/bin/env bash

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

sublime_package_manager_install()
{
  printf "%s\n" "The sublime package manager is installed on the PC? Y/N"
  read -r answer
  
  if [ "$answer" = "N" ] || [ "$answer" = "n" ]
  then
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
  
  cd ~/.config/sublime-text-3/Packages/ && mv User UserOld
  ln -s ~/.settings/sublime-config/User

  printf "%s\n" "Sublime-config installed."
}

main_install()
{
  sublime_package_manager_install
  sublime_config_install
}

main_install
