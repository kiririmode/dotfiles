#!/bin/bash

# show hidden files in Finder app.
defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder

# スクリーンショットを配置する場所を変更する
mkdir -p ~/Pictures/screenshot
defaults write com.apple.screencapture location ~/Pictures/screenshot
killall SystemUIServer
