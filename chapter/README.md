# Networking for DevOps: From Fundamentals to Secure Services

This project continues the original English chapter using its question-led explanations, definitions, Linux examples, four supplied illustrations, and two-column LaTeX layout. It covers the topics in the two networking exercise sets and adds an introduction and conclusion.

## Files

- `main.tex`: editable chapter.
- `references.bib`: relevant technical references.
- `images/1.png` through `images/4.png`: supplied illustrations, retained from the original project.
- `main.pdf`: compiled chapter.

## Build

From this directory, using a TeX installation that provides IEEEtran and the packages listed in `main.tex`:

```text
pdflatex -interaction=nonstopmode -halt-on-error main.tex
bibtex main
pdflatex -interaction=nonstopmode -halt-on-error main.tex
pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

Alternatively, upload `main.tex`, `references.bib`, and the `images` directory together to Overleaf, and select `main.tex` as the main document with pdfLaTeX as the compiler.

The examples are instructional commands, not fabricated execution records. Adapt interface names, addresses, accounts, and service names to the laboratory. Local DNS names ending in `.local` are retained where they correspond to the exercises; the text explains their multicast-DNS caveat.

The original `Devops.zip` is retained separately and has not been overwritten.
