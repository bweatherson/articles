import sys
import os

# Define your replacements here
REPLACEMENTS = {
    r'\alpha': 'α',
    r'\wedge': '∧',
    r'\neg': '¬',
    r'\vee': '∨',
    r'\rightarrow': '→',
    r'\forall': '∀',
    r'\exists': '∃',
    r'\in': '∈',
    r'\notin': '∉',
    r'\subset': '⊂',
    r'\subseteq': '⊆',
    r'\supset': '⊃',
    r'\leqslant': '⩽',
    r'\geqslant': '⩾',
    r'\leftrightarrow': '↔',
    r'\neq': '≠',
    r'\langle': '⟨',
    r'\rangle': '⟩',
    r'\beta': 'β',
    r'\gamma': 'γ',
    r'\delta': 'δ',
    r'\cup': '∪',
    r'\null': '∅'
    # Add more as needed
}

def replace_symbols(text, replacements):
    for latex, unicode_char in replacements.items():
        text = text.replace(latex, unicode_char)
    return text

def process_file(input_path):
    # Read the file
    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()
    # Replace the symbols
    new_content = replace_symbols(content, REPLACEMENTS)
    # Write to a new file (appending '_unicode')
    base, ext = os.path.splitext(input_path)
    output_path = f"{base}_unicode{ext}"
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"Processed file saved as: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 replace_latex_unicode.py <input_file>")
    else:
        process_file(sys.argv[1])

# Command to run the script:
# python replace_latex_unicode.py path/to/your/file.txt
# This script replaces LaTeX symbols with their Unicode equivalents in a text file.