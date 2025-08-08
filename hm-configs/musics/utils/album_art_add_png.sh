#!/usr/bin/env bash

for f in *.mp3; do
  eyeD3 --add-image=cover.png:FRONT_COVER "$f"
done
