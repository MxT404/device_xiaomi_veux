#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0

import hashlib
import os
import sys

def sha1sum_file(filepath):
    h = hashlib.sha1()
    with open(filepath, 'rb') as f:
        while True:
            chunk = f.read(8192)
            if not chunk:
                break
            h.update(chunk)
    return h.hexdigest()

def main():
    root = sys.argv[1] if len(sys.argv) > 1 else '.'
    output = sys.argv[2] if len(sys.argv) > 2 else 'proprietary-files.txt'
    
    entries = []
    for dirpath, dirnames, filenames in os.walk(root):
        if '.git' in dirpath:
            continue
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            relpath = os.path.relpath(filepath, root)
            sha1 = sha1sum_file(filepath)
            entries.append(f"{sha1}  {relpath}")
    
    entries.sort()
    
    with open(output, 'w') as f:
        for entry in entries:
            f.write(entry + '\n')
    
    print(f"Updated {output} with {len(entries)} entries")

if __name__ == '__main__':
    main()