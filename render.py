"""
Re-render everything:
$ RENDER_MODE=all python3 render.py

Re-render everything since HEAD (files you haven't committed yet)
$ RENDER_MODE=git-draft python3 render.py

Re-render everything since HEAD~1 (you made a commit and forgot to render it)
$ RENDER_MODE=git-post python3 render.py
"""


import os
from pathlib import Path
from subprocess import PIPE, run
import sys

render_mode = os.getenv("RENDER_MODE", "git-draft")

if render_mode == "all":
    print("Re-rendering all files. Brace for impact!")
    root_files = list(Path("./projects").glob("**/index.scad"))

elif render_mode == "git-draft":
    print("Re-rendering files changed since HEAD")
    git_process = run(
        ["git", "diff", "--name-only"],
        encoding="utf-8",
        stdout=PIPE,
    )
    changed_files = list(map(Path, git_process.stdout.splitlines()))
    root_files = [f for f in changed_files if f.name == "index.scad"]

elif render_mode == "git-post":
    print("Re-rendering files changed since HEAD~1")
    git_process = run(
        ["git", "diff", "--name-only", "HEAD~1"],
        encoding="utf-8",
        stdout=PIPE,
    )
    changed_files = list(map(Path, git_process.stdout.splitlines()))
    root_files = [f for f in changed_files if f.name == "index.scad"]

else:
    sys.stderr.write(f"Unknown mode: {render_mode!r}\n")
    sys.exit(1)

for in_file in root_files:
    out_file = in_file.with_name("index.stl")
    print(f"Rendering: {in_file} -> {out_file}")
    run([
        "openscad",
        str(in_file),
        "-o", str(out_file),
        "--export-format", "binstl",
    ])
    print()