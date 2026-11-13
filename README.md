# algorithm-paper-skills

Two Claude skills for writing algorithm engineering papers.

- `algorithm-paper-writing`: text. Abstracts, introductions, related work, algorithm descriptions, proofs, experiments, reviews. Plain style, no overselling, every claim backed by a number, proof, or citation.
- `paper-figures`: plots and tables. pgfplots, gnuplot, and TikZ templates, a colorblind-safe palette, booktabs tables. Each figure builds to its own PDF with `make`.

You can use each skill on its own.

## Install

Claude Code: copy a skill folder to `~/.claude/skills/`.

Claude apps: zip a skill folder and upload it under Settings → Capabilities → Skills.

## Example

Before:

> We propose a novel algorithm that significantly outperforms existing approaches. The experiments reveal that pruning plays a key role.

After:

> We present an algorithm that answers queries 2.3 times faster than RAPTOR on London (Table 3). Without pruning, queries are 3.1 times slower.
