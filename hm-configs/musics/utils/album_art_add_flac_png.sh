#!/usr/bin/env bash

for f in *.flac; do
  metaflac --import-picture-from=cover.png "$f"
done
