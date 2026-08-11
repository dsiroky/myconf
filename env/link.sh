#!/bin/bash

for fn in .??*; do
  if [ "$fn" != ".git" ]; then
    echo $fn
    rm ~/$fn
    ln -sf `pwd`/$fn ~/$fn
  fi
done
