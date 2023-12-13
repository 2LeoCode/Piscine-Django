#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Usage: $0 <bit.ly link> [bit.ly links...]"
  exit 1
fi

for link in $@; do
  short=$link
  case $short in
    http://*)
      short=${short#http://} ;;
    https://*)
      short=${short#https://} ;;
  esac
  short=${short#www.}

  case $short in
    bit.ly/*)
      ;;
    *) 
      echo "Invalid bit.ly url: $link"
      continue
      ;;
  esac

  location=$(curl -sI --connect-timeout 1 "$short" | grep "Location" | cut -b 11-)
  if [ -z "$location" ]; then
    echo "Failed to connect to: $link"
    continue
  fi
  echo $location
done
