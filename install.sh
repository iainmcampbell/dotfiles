#!/bin/bash

if [ $SPIN ]; then
  ln -sf ~/dotfiles/zshrc_imports ~/.zshrc_imports
  ln -sf ~/dotfiles/zshrc_spin ~/.zshrc
else
  ln -sf ./.dotfiles/zshrc_imports ~/.zshrc_imports
  ln -sf ./.dotfiles/zshrc ~/.zshrc
fi
