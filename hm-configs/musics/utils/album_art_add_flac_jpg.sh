#!/usr/bin/env bash

for f in *.flac; do
  eyeD3 --add-image=cover.jpg:FRONT_COVER "$f"
done
