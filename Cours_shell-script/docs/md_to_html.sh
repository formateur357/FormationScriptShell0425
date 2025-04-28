#!/bin/bash

for file in *.md; do
  pandoc "$file" -o "${file%.md}.html"
done
