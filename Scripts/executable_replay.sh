#!/usr/bin/env bash

obs-cmd replay save
replay_path=$(obs-cmd replay last-replay | sed -n 's/^Last replay path: //p')
view=$(notify-send -A View -a OBS -i OBS "Replay saved!" "Saved to $replay_path")
if [ $view = '0' ]; then
  video-trimmer "$replay_path"
fi

