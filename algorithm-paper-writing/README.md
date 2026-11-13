# algorithm-paper-writing

A Claude skill for writing algorithm engineering and algorithms-theory papers in a plain, checkable style.

The goal is a *simple* paper. A reader should quickly find what the contribution does, what it solves, where it is better than the alternatives, and where it is worse. Nothing is sold: no "novel" or "significantly" without evidence, no "up to" without the range, no hidden baseline that wins. The skill also removes common tells of machine-written prose, such as giving objects agency ("the columns separate the cases") and fancy words ("leverage", "delve").

For plots, diagrams, and results tables, use the companion skill `paper-figures`. The two skills work independently.

## Contents

```
SKILL.md                     entry point: output contract, sentence and word rules, who acts, checklist
references/
  framing.md                 stating the contribution, strengths and weaknesses, no overselling
  paper-structure.md         abstract, introduction, related work, technical sections, conclusion, theses
  explanation.md             technique habits and explanation craft for algorithm descriptions
  proofs.md                  statements, proof patterns, correctness of optimizations
  experiments.md             setup, verification, parameter studies, baselines, reporting
  review.md                  reviewing a draft, answering reviewers
assets/
  paper-macros.tex           booktabs, siunitx, theorem environments, \algname, \TODO, \GAP
```

## Installation

Copy the `algorithm-paper-writing` folder into your skills directory (for Claude Code: `~/.claude/skills/`), or upload the zipped folder in Claude's skill settings.

## Influences and recommended reading

The rules are house rules against inflation, distilled from reading algorithm engineering papers and theses in route planning and parallel algorithms. They are not a description of any one author's prose. Papers whose structure and honesty about tradeoffs informed the skill:

- Daniel Delling, Thomas Pajor, Renato F. Werneck. Round-Based Public Transit Routing. Transportation Science, 2015.
- Thomas Pajor. Algorithm Engineering for Realistic Journey Planning in Transportation Networks. PhD thesis, KIT, 2013.
- Julian Dibbelt, Thomas Pajor, Ben Strasser, Dorothea Wagner. Connection Scan Algorithm. ACM Journal of Experimental Algorithmics, 2018.
- Moritz Baum, Valentin Buchhold, Jonas Sauer, Dorothea Wagner, Tobias Zündorf. UnLimited TRAnsfers for Multi-Modal Route Planning: An Efficient Solution. ESA 2019.
- Jonas Sauer, Dorothea Wagner, Tobias Zündorf. Integrating ULTRA and Trip-Based Routing. ATMOS 2020.
- Ernestine Großmann, Jonas Sauer, Christian Schulz, Patrick Steil. Arc-Flags Meet Trip-Based Public Transit Routing. SEA 2023.
- Guy E. Blelloch, Jeremy T. Fineman, Yan Gu, Yihan Sun. Optimal Parallel Algorithms in the Binary-Forking Model. SPAA 2020.

## Testing status

The writing guidance has not been evaluated systematically. `paper-macros.tex` compiles with pdflatex (TeX Live 2023).
