# Reviewing a draft and answering reviewers

Contents: Reviewing a draft, Read-through order, Answering reviewers.

## Reviewing a draft

When asked to review or critique a draft, give comments, not a rewrite. Order them by importance: problems with claims and correctness first, structure second, wording last. Point to the location (section, line, figure) and give the fix in one sentence.

Check, in this order:

1. **Contribution.** Can the four sentences of the contribution test (`framing.md`) be extracted from the abstract and introduction? Is the weakness there?
2. **Claims against evidence.** For every claim in the abstract, introduction, and conclusion: where is the number, proof, or citation? Flag claims stronger than the experiments (conclusion drift, "up to" without range, "first" without scope).
3. **Correctness.** Are statements precise, assumptions stated, cases exhaustive, pruning rules justified? Mark gaps, do not fix them by guessing (`proofs.md`).
4. **Baselines.** Is the strongest baseline included, with the same optimizations? Is a baseline that wins somewhere still visible?
5. **Experiments.** Setup complete, parameters justified, results verified, variance reported, data defects named (`experiments.md`).
6. **Figures and tables.** Palette roles consistent, captions self-contained, axes honest (the paper-figures skill).
7. **Consistency.** One name per object, same notation in text, pseudocode, figures, and tables; same algorithm order everywhere.
8. **Wording.** The rules in `SKILL.md` (sentences, who acts, words).

## Read-through order

A useful last pass reads the paper the way a reviewer skims it: title, abstract, contribution list, all figures with captions, all tables with captions, conclusion. These alone must give a correct and not inflated picture. Then search the source for `TODO`, `GAP`, "significantly", "novel", "up to", "first", "clearly", "obviously".

## Answering reviewers

- Thank briefly once, at the top. Then answer each point in order, quoting or summarizing it first.
- Concede what is right. Say what was changed and where ("We added a comparison with X in Section 5.2, Table 4").
- If you disagree, give the reason with evidence, without irony. If the reviewer misread something, the text was probably unclear: clarify the text as well.
- Do not promise experiments you will not run. Do not add claims in the response that are not in the revised paper.
- If a requested comparison is impossible, say why in one sentence (no code available, different problem).
- Keep the tone of the paper: plain, specific, no flattery.
