#!/usr/bin/env bash

for f in *.mp3; do
  eyeD3 --add-image=cover.jpg:FRONT_COVER "$f"
done
