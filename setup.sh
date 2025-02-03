#!/bin/bash

DOTFILES_DIR="${HOME}/workspace/dotfiles"

ln -s "${DOTFILES_DIR}/.alacritty.toml" "${HOME}/.alacritty.toml"
ln -s "${DOTFILES_DIR}/.editorconfig" "${HOME}/.editorconfig"
ln -s "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -s "${DOTFILES_DIR}/.irbrc" "${HOME}/.irbrc"
ln -s "${DOTFILES_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -s "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
ln -s "${DOTFILES_DIR}/php/custom.ini" "$(brew --prefix)/etc/php/8.4/conf.d/custom.ini"

if [[ $(uname) == 'Darwin' ]]; then
    ln -s "${DOTFILES_DIR}/.zshrc_mac" "${HOME}/.zshrc_mac"
else
    mkdir -p "${HOME}/.config/environment.d"
    ln -s "${DOTFILES_DIR}/.config/environment.d/im.conf" "${HOME}/.config/environment.d/im.conf"
fi
