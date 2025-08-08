#!/usr/bin/env bash

for f in *.flac; do
  eyeD3 --add-image=cover.png:FRONT_COVER "$f"
done
