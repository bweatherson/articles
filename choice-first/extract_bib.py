#!/usr/bin/env python3
"""
Extract cited bibliography entries from a markdown file.

Usage:
    python extract_bib.py input.md bibliography.bib output.bib
"""

import re
import sys
from pathlib import Path


def extract_citation_keys(markdown_file):
    """Extract all citation keys from a markdown file."""
    with open(markdown_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Match Pandoc-style citations: [@key], [@key1; @key2], @key
    # Also matches variations like [-@key] and [see @key, pp. 1-2]
    citation_pattern = r'@([\w:_-]+)'
    
    keys = set(re.findall(citation_pattern, content))
    return keys


def parse_bib_file(bib_file):
    """Parse a .bib file into individual entries."""
    with open(bib_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Match bib entries: @type{key, ... }
    # This handles nested braces correctly
    entries = {}
    
    # Split on @ at the start of a line, keeping the @
    parts = re.split(r'\n(?=@)', content)
    
    for part in parts:
        if not part.strip() or not part.startswith('@'):
            continue
        
        # Extract the citation key
        match = re.match(r'@\w+\{([^,\s]+)', part)
        if match:
            key = match.group(1)
            # Store the complete entry
            entries[key] = '@' + part if not part.startswith('@') else part
    
    return entries


def extract_cited_entries(markdown_file, bib_file, output_file):
    """Extract cited entries and write to output file."""
    # Get citation keys from markdown
    citation_keys = extract_citation_keys(markdown_file)
    
    if not citation_keys:
        print("Warning: No citations found in markdown file")
        return
    
    print(f"Found {len(citation_keys)} unique citation keys")
    
    # Parse bib file
    all_entries = parse_bib_file(bib_file)
    print(f"Parsed {len(all_entries)} entries from bibliography file")
    
    # Extract cited entries
    cited_entries = []
    missing_keys = []
    
    for key in sorted(citation_keys):
        if key in all_entries:
            cited_entries.append(all_entries[key])
        else:
            missing_keys.append(key)
    
    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        for entry in cited_entries:
            f.write(entry.rstrip() + '\n\n')
    
    print(f"Wrote {len(cited_entries)} entries to {output_file}")
    
    if missing_keys:
        print(f"\nWarning: {len(missing_keys)} cited keys not found in bibliography:")
        for key in sorted(missing_keys):
            print(f"  - {key}")


def main():
    if len(sys.argv) != 4:
        print("Usage: python extract_bib.py <markdown_file> <bib_file> <output_file>")
        print("\nExample:")
        print("  python extract_bib.py article.md references.bib cited.bib")
        sys.exit(1)
    
    markdown_file = sys.argv[1]
    bib_file = sys.argv[2]
    output_file = sys.argv[3]
    
    # Check files exist
    if not Path(markdown_file).exists():
        print(f"Error: Markdown file not found: {markdown_file}")
        sys.exit(1)
    
    if not Path(bib_file).exists():
        print(f"Error: Bibliography file not found: {bib_file}")
        sys.exit(1)
    
    extract_cited_entries(markdown_file, bib_file, output_file)
    print("\nDone!")


if __name__ == '__main__':
    main()
