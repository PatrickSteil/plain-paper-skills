---
name: algorithm-paper-writing
description: "Write, revise, or review algorithm engineering and algorithms-theory papers in a plain, checkable style: the gap in prior work is a mechanism, every claim has a number, proof, or citation, and weaknesses are stated beside strengths. Use for abstracts, introductions, contributions, related work, definitions, lemmas, proofs, algorithm descriptions, experiment write-ups, conclusions, rebuttals, and thesis chapters on algorithms (route planning, graph, parallel algorithms), for requests such as \"don't oversell\", \"make this plainer\", or \"less LLM-sounding\", and for pasted LaTeX from such a paper. For plots, diagrams, and results tables, use the paper-figures skill."
---

# Algorithm Paper Writing

Write like a careful algorithm engineering paper: concrete, checkable, and easy to follow. The gap in prior work is a mechanism. The algorithm is simple. Every claim has a number, a proof, or a citation. Weaknesses are stated as plainly as strengths. A reader finds quickly what the contribution does, what it solves, where it is better, and where it is worse. Nothing is sold.

## Output contract

- Respond only with the written or revised text. No introduction, no summary of changes, no closing offer. Give comments only if the user asks for a review or critique (`references/review.md`).
- Keep the author's technical content. Change wording, order, and structure. Do not add, remove, or strengthen claims.
- Never invent numbers, instances, citations, bounds, or results. Write a visible placeholder such as `[TODO: speedup on Europe]` (`\TODO{...}` in LaTeX).
- A proof step that does not follow gets `\GAP{what is missing}` and a one-line note after the text (`references/proofs.md`).
- If the input is LaTeX, answer in LaTeX. Leave `\cite`, `\ref`, `\label`, and custom macros unchanged.
- Match the language and the spelling (American or British) of the input.

## Workflow

1. Decide what the request is, and read the matching reference:

| Task | Read |
|---|---|
| abstract, introduction, contributions, conclusion, any framing of results | `references/framing.md`, then `references/paper-structure.md` |
| preliminaries, related work, algorithm description, extensions, thesis chapter | `references/paper-structure.md`, then `references/explanation.md` |
| explaining an algorithm or optimization, section opener, design narrative, future work | `references/explanation.md` |
| lemma, theorem, proof, correctness argument, running time | `references/proofs.md` |
| experiments section, any text that reports measurements | `references/experiments.md`, then `references/explanation.md` §8–9 |
| review a draft, pre-submission check, answer reviewers | `references/review.md` |
| plot, diagram, colors, results table | the paper-figures skill, if installed |

2. Write or revise using the rules below.
3. Run the checklist at the end. Fix violations before answering.

`assets/paper-macros.tex` is a paper preamble with booktabs, siunitx, theorem environments, `\algname`, `\TODO`, and `\GAP`.

## Sentences

- One claim per sentence. Vary the length: a median around 20 words, a third at 15 or fewer, an occasional long one. A long sentence holds one main clause plus parenthetical glosses ("(i.e., ...)", "(cf. Section 3)"). Do not stack subordinate clauses.
- Active voice, "we" for the authors. Present tense for what the paper and the algorithm do; past tense for experimental actions ("We ran 10 000 queries"); present tense for observations ("We observe that ...").
- Point first, then reasons and qualifications.
- No hedging ("could potentially", "it seems that"). Support the claim, or label it a conjecture, assumption, or hypothesis.
- No evaluative adjective ("novel", "powerful", "elegant", "significant", "efficient", "practical") without a number, proof, or citation in the same paragraph.
- No rhetorical questions, exclamation marks, or metaphors for color. Em dashes rarely.
- No filler ("it is worth noting that", "plays a key role in", "in this paper we aim to explore") and no rhythm devices (triplets for effect, "not only ... but also", sentence-final participle clauses such as "..., making it faster").
- "Note that ..." is the plain transition for a caveat. End with the results, not with "In conclusion, we have shown ...".

## Who acts

A verb must be literally true of its subject. The common failure is that every noun is slightly animate ("the columns separate the cases", "the test is blocking revision", "the bound captures the cost") while the people who decide and observe disappear.

- **People act.** Observing, choosing, deciding, proposing, assuming, and concluding are done by people: "we", "Delling et al.", "the reviewer", "a passenger". Name them.
- **Things that execute act mechanically.** An algorithm, query, procedure, or data structure may compute, scan, store, return, run, update, discard, or take time. It does not try, want, prefer, struggle, decide, know, or see.
- **Static things do not act.** Tables, columns, figures, sections, bounds, lemmas, numbers, results, tests, and drafts do not separate, reveal, highlight, capture, tell, drive, protect, or block anything. The accepted convention: a table, figure, or section *shows*, *lists*, *reports*, *gives*, or *describes*; a lemma *states* or *implies*.
- **Do not hide the person behind a passive.** "It was decided to use X" becomes "We use X, since ...".

| Avoid | Use |
|---|---|
| The columns separate the cases. | Columns 2–4 give query times for one criterion, columns 5–7 for two. |
| The experiment reveals that pruning matters. | Without pruning, queries are 3.1 times slower (Table 4). |
| This bound captures the cost of scanning routes. | The term $k \cdot \lvert R \rvert$ is the cost of scanning routes. |
| Route marking drives most of the speedup. | Most of the speedup comes from route marking (3.1 of 3.8; Table 4). |
| The rule protects correctness. | The rule is safe: it discards only dominated labels (Lemma 2). |
| The algorithm tries to avoid rescanning. | The algorithm does not rescan a route unless one of its stops improved. |

Test: could the subject do this if it were a machine running the code, or a person? If neither, rewrite with the person, or with "is" and the fact.

## Words

Use the plainest word that is precise. Do not vary words for style.

| Avoid | Use |
|---|---|
| utilize, employ, leverage, harness | use |
| facilitate | let, allow |
| elucidate, showcase | explain, show |
| subsequently, prior to, in order to | then, before, to |
| a plethora of, myriad | many |
| builds upon, takes a step further | extends, generalizes (and say what changed) |
| seamless, robust, comprehensive (non-technical) | drop, or give the property |
| delve, landscape, pivotal, underscore, crucially, notably, thereby | drop |

Do not coin noun phrases for what a verb says: "the passenger stays on the trip", not "stay-on-board move".

## Terms and notation

- Introduce each symbol, term, and algorithm name once (`\emph{...}` at the definition) and use it unchanged afterwards. One name per object. Fixed capitalization (RAPTOR, McRAPTOR).
- Reuse notation from the closest prior paper. If a term could be confused with another, say which one you chose and why.
- Use formulas where they are shorter or clearer than words.
- State differences to a simpler case as facts: "A transfer-count label stores one value per stop. This label stores a set of pairs."

## Claims and evidence

- Support each claim with a number, proof, experiment, or citation. "Faster", "smaller", "better" only next to a ratio or a table reference: "2.3 times faster than Y on Europe".
- Scope novelty: "To the best of our knowledge, no algorithm achieves X in model M."
- Write bounds exactly, with their type (worst case, expected, whp), and state prior bounds in the same terms.
- "Up to X" only with the range or the median.
- Name the cost and the weaker regime of every contribution (preprocessing, space, restricted input, a faster competitor, a share of wrong answers). A limitation that changes what is solved goes into the abstract.
- A draft without experiments has no performance numbers.
- Use the weakest wording the evidence supports (calibration table in `references/framing.md`).

## Checklist before answering

- The first paragraph states the problem; the gap in prior work is a mechanism.
- Every evaluative word has a number, proof, or citation next to it; no word from the table is left.
- No static object is the subject of an action verb beyond shows/lists/reports/gives/states.
- Each technical object has exactly one name, kept in later sections, tables, and the ablation.
- No invented numbers, bounds, or citations; bounds state their type.
- The cost or weakness is stated where the strength is stated; the strongest baseline appears, including where it wins.
- Every proof step follows; gaps are marked, not covered with "clearly".
- Each section opens with what it does and ends with what was built and what is open.
- The output contains only the text (unless the output contract says otherwise).
