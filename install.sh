#!/bin/bash

ln -sf $(pwd)/zshrc ~/.zshrc
ln -sf $(pwd)/zshrc_imports ~/.zshrc_imports

ln -sf $(pwd)/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf $(pwd)/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf $(pwd)/vscode/snippets ~/Library/Application\ Support/Code/User/snippets