# Explanation craft

Contents: Technique habits, then eleven explanation habits (1 orientation, 2 objections, 3 failure-and-fix chains, 4 plain and formal definitions, 5 examples, 6 requirements, 7 design decisions, 8 weaknesses, 9 experiments by question, 10 future work, 11 thesis chapters).

## Technique habits

1. **Name the failure as a mechanism.** "Dijkstra-based algorithms perform priority queue operations and are hard to parallelize." Not "existing approaches are limited."
2. **Say what the algorithm does mechanically, then why it works.** Describe the loop in plain verbs, then give the invariant or the argument.
3. **State invariants before the algorithm.** "At the beginning of round k, the first k entries are correct." Correctness then follows from the invariant.
4. **Give intuition, then the formal statement.** Use "To see why ..., consider ..." or "Intuitively, ..." before a lemma. Use a tiny concrete example (two journeys, an eight-element list).
5. **Order: basic version, improvements, extensions.** Present the simplest correct algorithm first. Add each optimization as its own step. Give each extension its own name and subsection.
6. **Derive the running time next to the algorithm** and compare it with the competitors' bounds.
7. **Explain choices that look arbitrary.** One sentence on why a term, parameter, or step is as it is.
8. **Move side remarks to footnotes, data structures to an appendix, and long proofs to an appendix with a proof outline in the text.**
9. **Separate engineering from the algorithm.** Describe implementation tricks (memory layout, SIMD, avoiding allocation) in their own subsection and measure each one in an ablation.
10. **State scope and exclusions explicitly.** "Direct comparison with X is difficult, since it does not support Y." "Label construction is out of scope for this note."
11. **Keep proofs short and local.** A correctness proof by contradiction can take six lines when the definitions are tight. For a hardness result, give the construction first, then both directions of the reduction, and follow it with the pseudo-polynomial or restricted case that is solvable. State a worst-case bound and, separately, what to expect in practice and why ("faces have constant size on realistic inputs").

## Explanation craft

These habits make a long algorithm text easy to follow. Apply them to algorithm descriptions, related work, chapter and section openers, experiments, and conclusions. They never license a claim the evidence does not support.

### 1. Always tell the reader where they are

- Open every chapter and main section with a short plain statement of what it does. In a long chapter, give one paragraph per part, in the order of the sections (the problems, the models, the algorithms), then an "Overview" paragraph that names each section and what it contains. A short section gets the same in two or three sentences.
- Start each paragraph with a bold run-in heading that names its one idea: "Round-Based Approach.", "Marking Routes.", "Local Pruning.", "Target Pruning.". Use that name again, unchanged, in the ablation, in table columns, and in later sections. A paragraph under a heading covers that idea only.
- Restate a needed definition at the point of use with "Recall that ..." and add a parenthetical cross-reference ("cf. Section 4.1") when the full definition is far away. Do not send the reader back to find it.
- Before extending a known technique, recap it briefly, with a tiny worked figure (numbers on the arcs, which shortcut is added and why).
- Close each main section with a short conclusion: what was built, what was measured (the main numbers), what is open.

### 2. Answer the reader's objection before they raise it

For every optimization and every unusual choice, use this order: the naive step, a sentence saying it looks wasteful or wrong, a confirmation or refutation ("Indeed, there is no need to ..., since ..."), the exact rule ("More precisely, ..."), the argument ("To see why, consider ..."), and then how it is implemented. Give the motivation before the exact rule, never after.

### 3. Write paragraphs as failure-and-fix chains

Related work, model sections, and algorithm descriptions run: approach, then its limitation (with a number or a mechanism), then the response. Connectives have fixed jobs. Use them for those jobs only.

| Connective | Job |
|---|---|
| Unfortunately, | the specific limitation of an approach; the next clause gives a number or a mechanism |
| Therefore, / Hence, / Thus, | the response to, or consequence of, the previous sentence |
| Moreover, | another property of the same thing |
| However, | a limit on the sentence before |
| Note that | an assumption, caveat, or consequence the reader might miss; often in parentheses |
| Recall that | a definition or fact needed right now |
| More precisely, | the exact rule after the plain version |
| Interestingly, | an unexpected result; the next sentence gives the cause |
| As expected, | the result was predicted by the analysis |
| In fact, | stronger evidence for the previous claim |
| Intuitively, | the picture before the formal statement |

Keep the frequency low: "Note that" about twice per 1 000 words, "Recall that" about once per 2 000. Do not overuse "Moreover". Do not use the words from the word table in `SKILL.md`.

### 4. Pair every formal definition with a plain one

- Introduce the object in plain words first ("Roughly speaking, a timetable consists of stops, routes, and trips. A trip is a vehicle that serves a route at a specific time."), then give the tuple, then one sentence per component. Add a gloss for abstract sets ("think of the period as the seconds of a day").
- For a variant of an algorithm, give a one-sentence reading ("Think of it as running Dijkstra's algorithm for every outgoing connection at once.").
- Put glosses and references in parentheses so the main sentence stays straight.

### 5. Use examples from real data, chosen to break the naive notion

- Make the smallest example concrete: real station names, lines, and minutes, not anonymous vertices.
- Introduce a refined definition with a case where the simple one gives a surprising answer. Example pattern: the earliest-arrival journey need not have minimum travel time, because slack time can be spent on a detour, so a "tight" journey is defined. Say "This may seem counterintuitive at first" and then give the case.
- One figure per idea. Draw techniques that are compared with the same visual vocabulary (same source, target, shading). The caption says what to look at: what is bold, what is faded, which round a route is scanned in.
- When a simple model explains an observed number, derive it, then compare: the area argument for two discs predicts a speedup of 2 for bidirectional search, "which is also observed in practice".

### 6. State requirements first; judge prior work by them

- List the properties the solution must have. State which of them no existing method meets together.
- Group prior methods by the property they rely on (strong hierarchy, goal direction, separators), not by year. For each group, name the specific way it fails the requirements in this setting.
- Pick the group that fits and say why. If a group was dismissed earlier, say why (the published speedups) and what changed (new partitioner, reengineering).
- A rough qualitative table of prior methods against the requirements is fine if it is labeled rough.
- Quote the prior authors' own verdict when it makes the point better than your opinion. Credit prior work at its best. Mention where prior methods are in use in practice, and list your own system as one entry among them.

### 7. Show the design as a sequence of decisions

- Announce the order: a basic algorithm first, then techniques to make it practical, with experiments guiding the design.
- For each technique: description, an evaluation paragraph with numbers, and a decision sentence ("Since X is nearly as fast, we use Y as the default").
- Report what was dropped and why: gains were moderate and cost preprocessing time, implementation complexity, or a required property. A dropped technique is a result.
- Carry a decision forward and say so ("we use this model in all subsequent experiments").

### 8. Write weaknesses as consequences of the analysis

- Derive the bound first. When a result is weak, point to the quantity in the bound: if the time is determined by the number of routes scanned per round, then the slow instance is explained by its much larger number of routes (give both counts).
- When a baseline wins, say where, by how much, and why, using a machine-independent count (fewer queue operations, so the advantage in scans does not become the same speedup).
- Put the scope limit in the introduction, beside the contribution: not meant to be fastest on every input, slower than the best specialized method on easy inputs, and why that is acceptable.
- For parallel results, report the slowdown on one thread, the core count where extra cores stop paying off, and the cause (sequential fraction, memory contention), marked as a cause.
- Say what is arbitrary or unsolved ("defined somewhat arbitrarily", "no absolute quality measure yet").

### 9. Organize experiments by question

- Each group of experiments opens with its question ("how well does the algorithm scale with the number of cores?" written as a statement), then the setup, then one sentence on what the column groups mean, then "We observe that ..." with the cause, then the decision it leads to.
- Use "Interestingly" for a surprise and "as expected" for a predicted result. Give the cause in both cases.
- When quality has no ground truth, define the reference (the exact algorithm), define the similarity measure, report mean and standard deviation, and keep rows with poor quality in the table.
- Disclose every parameter value. If the text promises a sensitivity study ("robust to small variations"), include it.
- Avoid "results for other instances are similar" without a number or a table.

### 10. Close with a lesson and concrete future work

- A future-work item has four parts: the limitation, named from the analysis; the intuition for why it can be fixed; a first approach, with the related technique; and what makes it hard.
- If the work supports one cross-cutting observation (for example: the problems are memory bound, so memory layout decides performance), state it once in the final chapter, with the evidence behind it. Do not write a mission statement.

### 11. Thesis chapter template

- Opener: the problem in plain words; why "optimal" is not obvious (time dependence, several criteria); the models; the algorithms; the overview paragraph.
- A "References" paragraph after the overview: the papers the chapter is based on, their venues, the coauthors, and which parts the thesis author contributed. Thank people by name for data and discussions.
- Order inside a chapter: inputs, problems from simple to general, models, basic algorithms (used as baselines), own algorithms, experiments, conclusion.
- Each chapter ends with a conclusion that states what was shown and what is open (see `paper-structure.md`, Theses).
