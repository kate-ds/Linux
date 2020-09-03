#!/bin/bash
OUTPUT=$(sed -e '/^$/d; s/\(.*\)/\U\1/'  $1)
echo $OUTPUT
if $2

