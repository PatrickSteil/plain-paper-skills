# Paper structure

Contents: Abstract, Introduction, Contributions, Preliminaries, Related work, Main technical section, Theorems and proofs, Model section, Extensions, Implementation and appendices, Conclusion, Technical notes, Theses.

The patterns below come from published papers on RAPTOR, the Connection Scan Algorithm, Trip-Based Routing, ULTRA, Arc-Flag TB / FLASH-TB, and parallel algorithms in the binary-forking model (full references in the README). Templates are generic. Fill them with the author's facts only.

## Standard section order

1. Abstract
2. Introduction
3. Preliminaries (notation and problem definitions)
4. Related work (fold into the introduction in short papers)
5. Main technical sections
6. Extensions (optional)
7. Experiments
8. Conclusion

End the introduction with a roadmap that names each section and what it contains, for example: "Section 2 defines the problem. Section 3 describes the algorithm. Section 4 presents extensions. Section 5 reports experiments. Section 6 concludes." Omit it in very short papers.

## Abstract (5 to 8 sentences)

Engineering pattern:

1. Problem: "We study the problem of computing X in Y for criteria Z."
2. Prior work and its failure, as a mechanism: "Existing algorithms model this as a graph problem and use variants of Dijkstra's algorithm. This leads to either high query times or suboptimal solutions."
3. Idea: "We take a different approach. We introduce A." Name A once.
4. Two or three properties of A, each concrete and checkable: "It is not Dijkstra-based. It scans each route at most once per round. It does not need preprocessing, so it works in dynamic scenarios."
5. Extensions, if any, in one sentence.
6. One result with instance and number, only if the paper reports experiments: "On the full network of London, A computes all Pareto-optimal journeys in under 8 ms."
7. The main cost or limitation, if it changes what the contribution is: the preprocessing or space it needs, a faster technique it does not beat, a share of wrong answers. The Arc-Flag TB paper states in its abstract that labeling techniques are faster but need far more memory, and gives its own error rate. See `framing.md`.

Theory pattern:

1. List the problems solved.
2. Define the model in two sentences (what a task can do, how cost is measured).
3. State the tension: what is known in the standard model, and what a direct simulation costs in the new model.
4. State the result in one sentence with its scope: "These are the first algorithms with optimal work and span in model M."

Do not put numbers in an abstract of a paper without experiments. A preprocessing or algorithmic note states what is given, not a speedup.

## Introduction

Use six short paragraphs, in this order.

1. **Problem.** Define it in plain words. Give the setting (road network, transit network, shared-memory machine). One short paragraph.
2. **The obvious approach and why it falls short.** Name the standard tool. Give one fact on where it works and one fact on where it fails. Prefer a number: for example, speedups of a known technique on one network type versus another.
3. **State of the art, concretely.** For each relevant approach, say what it does and its main limitation (preprocessing time, space, no multi-criteria support, loses optimality, cannot handle dynamic updates). Name what the approaches have in common if there is a shared limitation. This is a critical comparison, not a list of citations.
4. **Our approach.** One paragraph: what changes and why that removes the limitation named in paragraph 3. Describe the algorithm in a sentence of plain verbs ("it operates in rounds, one per transfer, and scans every route at most once per round"). If the idea comes from an observation, state the observation and its source (ULTRA: preliminary experiments showed that intermediate transfers are rarely relevant). Name what the approach costs or does not do in the same paragraph.
5. **Contributions.** Itemized, each item one clause.
6. **Outline** (optional).

Theory variation: define the model and the cost measures in the introduction, because the model is part of the contribution. Justify the model's realism with concrete systems and hardware facts. Compare it with the traditional model through one concrete example where the two give different bounds. State the main theorem in the introduction. Add a results table (problem, section, bound, bound type). Close with open questions.

Do not repeat the abstract's sentences in the introduction.

## Contributions

Format: "Our contributions are: (i) ..., (ii) ..., (iii) ...". Each item is one clause with a concrete object.

- Claim only what the paper proves or measures. In a note without experiments, claim only definitions, lemmas, and algorithms with correctness arguments.
- Do not justify an item inside the item.
- Avoid evaluative words. Write "an algorithm with O(n) work and O(log n) span" rather than "a powerful algorithm".
- A negative finding is a contribution and can be listed: an issue found in prior work, a regime where the technique does not help.

## Preliminaries

Put notation and problem definitions here once, not scattered across the paper.

- Define the input formally as a tuple, then explain each component in plain words. Add a parenthetical gloss for abstract sets ("think of the period as the seconds of a day").
- Define problems from simple to general. Each problem is a generalization of the previous one: earliest arrival, then multi-criteria, then range.
- Define dominance, Pareto set, or the optimality criterion before using it.
- Give one tiny concrete example of an output (two journeys that do not dominate each other: one arrives at 4 p.m. with 2 transfers, one at 3:30 p.m. with 3 transfers).
- If the chosen term collides with another field's term, state the choice and the reason in a footnote ("We use line instead of route to avoid confusion with routing").
- Define cost measures where they are first needed. For work and span: work is the total number of instructions, span is the longest chain of dependent instructions.

## Related work

- Organize by model or by technique, not by year. An engineering paper: first the graph models (time-expanded, time-dependent), then the algorithms for each problem. A theory paper: by model variant, then by problem.
- Describe each approach mechanically in two to four sentences, then give its limitation or cost: "As Dijkstra variants, each of them performs costly priority queue operations."
- Compare on preprocessing time, space, query time, input model, and exact versus heuristic. Use a table if there are three or more competitors.
- State prior bounds in the target model. Example: an algorithm that is optimal in the old model has a given bound in the new one. This makes the gap visible.
- End each subsection with a scoped statement of what is missing: "As far as we know, no algorithm for X achieves Y in model M."
- Cite only work that the technique is compared against or built on. No survey of unrelated work.
- In a long paper, each major technical section may open with its own short background paragraph that states the known lower bound and the best known algorithm.

## Main technical sections

Order inside a section: definition, then the property that makes it work, then the algorithm that uses it.

**Opening.** State the problem of the section in one or two sentences. State the main result of the section before the details ("The main result of this section is a randomized algorithm with linear work and logarithmic span").

**Algorithm presentation (engineering pattern).**

1. Introduce the basic version in plain words with the invariant: "Round k computes the earliest arrival at every stop with at most k trips. At the beginning of round k, the first k entries of every label are correct."
2. Describe the stages of one round, each in one paragraph.
3. Give the pseudocode with short comments on the lines that are not obvious.
4. Derive the worst-case running time in the text. Compare it with the competitors: "A similar analysis for model X shows that Y is slower by at least a logarithmic factor because of priority queues."
5. Present improvements one by one, each with the reason it helps: "There is no need to scan routes that were not reached in the previous round, since no trip can be boarded." Name each improvement (marking, local pruning, target pruning).
6. Present features that change the output (transfer preferences, journey reconstruction) in separate subsections.
7. Present parallelization as its own subsection with the conflict it must resolve and the technique that resolves it.

**Algorithm presentation (theory pattern).**

1. State what prior algorithms do and why that costs extra in this model (for example, they are round-based and need Ω(log n) rounds, which gives Ω(log² n) span).
2. Give the algorithm as short pseudocode. Refer to lines by number in the text.
3. State the key idea in two or three sentences: what is done asynchronously, in a different order, or with a different split, and what that saves.
4. Walk through a small example with a figure. The caption explains the example fully.
5. State the theorem with exact bounds and their type.
6. Prove it.

**Pseudocode.**

- One algorithm, one purpose. Name inputs and outputs.
- Use the same names as in the text and the preliminaries.
- Split a long algorithm into a main procedure and named subprocedures.

**Figures.**

- One figure per idea. Use small instances. Caption states what to see in it. For drawing it, see the paper-figures skill (Diagrams).

## Theorems and proofs

Read `proofs.md` before writing or revising any proof. The short version:

- Present definitions, lemmas, and theorems as separate numbered blocks.
- State a theorem with all its parameters: "Algorithm 1 does O(n) work in the worst case and has O(log n) span with high probability in n." Define "with high probability" once, in a footnote or the preliminaries.
- Put a proof or proof sketch after each theorem. Start a sketch with "Intuitively," or "Proof outline." and then give the main argument.
- Prove correctness by reduction when possible: "The algorithm applies the same operations as [X], so correctness follows."
- Split cost proofs into work and span, or into time and space. State each bound separately, then combine: "Combining Lemmas 4, 5, and 6 proves the theorem."
- Put lemmas that need long calculations in an appendix. Keep a short intuition in the main text and point to the lemma number.
- When citing a known result as a theorem, restate its bound and say why it is tight if it is: "This is asymptotically optimal, since the simulation needs at least W/P and at least S."
- If a weaker algorithm is also given, say what it lacks and what it keeps: "While not work-optimal, this variant is deterministic."

## Model section (when the paper uses a new or unusual model)

- Define the model formally in one place, with each primitive.
- State how the cost measures are defined on it.
- Relate it to the standard models with theorems or short statements, including which direction of simulation costs how much.
- State why a primitive is included (all hardware supports it) in one sentence.

## Extensions

- One subsection per extension. Give each a new name only if it is a different algorithm (McRAPTOR for more criteria, rRAPTOR for range queries).
- Start with the new problem, then give the change to the base algorithm, then what stays the same (pruning, parallelization).
- Use one concrete example that makes the extension tangible (fare zones with bit sets: dominance is a bitwise test, union is a bitwise or).

## Implementation and appendices

- Put engineering that does not change the algorithm in an "Implementation" subsection: memory layout, avoiding dynamic allocation, SIMD, cache locality. Say what each does and measure it in the experiments.
- Put data structure details (array layouts, index arrays, forward-star representations) in an appendix. Name every array and say what it stores.
- State fixed limits that the implementation relies on, with the evidence: "No test instance had a Pareto-optimal journey with 16 or more transfers, so we set the maximum to 15."

## Conclusion

- Three to five sentences. State what was built and what was measured, with the main numbers.
- State the main weakness with the same weight as the main strength. Write the conclusion from the experiments section, not from the abstract, so it does not drift into stronger claims.
- Do not begin with "In conclusion". Do not restate the introduction.
- End with concrete future work: open questions the construction leaves unsolved (continental-size networks, delay handling, additional criteria). Not a mission statement.
- Name the limitations that remain.

## In-progress technical notes (no experiments)

- Omit the Experiments section.
- State once what is out of scope.
- List only claims that the note proves.
- End with an explicit list of open questions (construction algorithm, parameter tuning, experimental validation).

## Theses

Conventions common in algorithm engineering theses. Adapt them to the source material.

- The introduction defines all problem variants considered and states which chapter solves which.
- Each technical chapter reads like a paper: problem, related work for that problem, approach, experiments, summary.
- Notation is defined once in a preliminaries chapter and reused.
- Each chapter ends with a summary of what was shown and one open question.
- The conclusion lists results across chapters and open problems. It does not repeat chapter summaries.
