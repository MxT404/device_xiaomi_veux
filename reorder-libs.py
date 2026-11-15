#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0

import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: reorder-libs.py <file>")
        sys.exit(1)
    
    filepath = sys.argv[1]
    with open(filepath, 'r') as f:
        lines = f.readlines()
    
    libs = []
    non_libs = []
    for line in lines:
        stripped = line.strip()
        if stripped.endswith('.so') or stripped.endswith('.so:'):
            libs.append(line)
        else:
            non_libs.append(line)
    
    libs.sort()
    
    with open(filepath, 'w') as f:
        for line in non_libs:
            f.write(line)
        for line in libs:
            f.write(line)
    
    print(f"Reordered libraries in {filepath}")

if __name__ == '__main__':
    main()