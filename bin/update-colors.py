#!/usr/bin/env python

import os
import re
import sys
import select

# Base16 definitions

# Custom Monokai
colors = [
    "#1d1f21",
    "#cc342b",
    "#14b363",
    "#fba922",
    "#3971ed",
    "#b028e9",
    "#0abdae",
    "#cecdc3",
    "#878988",
    "#c49c9a",
    "#93b6a4",
    "#c8b394",
    "#859acb",
    "#a884b8",
    "#7c9e9b",
    "#f1f3f5",
]

# Xterm defaults
# colors = [ "#000000", "#800000", "#008000", "#808000", "#000080", "#800080", "#008080", "#c0c0c0", "#808080", "#ff0000", "#00ff00", "#ffff00", "#0000ff", "#ff00ff", "#00ffff", "#ffffff", ]

colors = [c.replace("#", "") for c in colors]
marker_regexp = re.compile(r".+ (c\d{1,2})")
color_regexp = re.compile(r".*([a-f0-9]{6}).*")

files = []

rlist, _, _ = select.select([sys.stdin], [], [], 0.0)
if rlist:
    files = sys.stdin.read().splitlines()
else:
    files = os.popen("git ls-files").read().split("\n")

files = [f for f in files if os.path.isfile(f)]

for f in files:
    file_changed = False
    previous_line_marker = None

    with open(f, "r") as c:
        lines = c.readlines()

    for i, line in enumerate(lines):
        marker = marker_regexp.match(line)
        if marker is not None:
            marker = marker.group(1)

        color = color_regexp.match(line)
        if color is not None:
            color = color.group(1)

        if marker is not None:
            previous_line_marker = None

            if color is not None:
                new_color = colors[int(marker[1:]) - 1]
                new_line = line.replace(color, new_color)
                if line != new_line:
                    file_changed = True
                    lines[i] = new_line
            else:
                previous_line_marker = marker

        elif previous_line_marker is not None:
            marker = previous_line_marker
            previous_line_marker = None

            if color is not None:
                new_color = colors[int(marker[1:]) - 1]
                new_line = line.replace(color, new_color)
                if line != new_line:
                    file_changed = True
                    lines[i] = new_line

    if file_changed:
        print("File changed:", f)
        with open(f, "w") as c:
            c.writelines(lines)
