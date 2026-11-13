# Proofs and correctness arguments

Contents: Rules for the assistant, What needs a proof, Statements, Proof patterns, Running time, Heuristics and optimizations, Counterexamples, Layout, Checklist.

## Rules for the assistant

These rules come first because a wrong proof is worse than a missing one.

- **Never invent a proof step.** If a step does not follow from what is stated, write `\GAP{what is missing}` (or `[PROOF GAP: ...]`) and continue. Do not cover it with "clearly", "it is easy to see", or "by a standard argument".
- **Never strengthen a statement** to make a proof go through, and never weaken it silently. If the proof only works under an extra assumption, add the assumption to the statement and tell the author.
- **Check every case.** A case analysis must say why the cases are exhaustive.
- **Separate what you verified from what you formatted.** When asked to write up a proof from notes, keep the author's argument. If you find a hole, flag it in a short note after the text, even if the output contract says "text only". A silent hole is not acceptable.
- **Ask for the definitions** if they are not given. Do not guess the definition of dominance, of a feasible journey, or of a transfer.

## What needs a proof

In an algorithm engineering paper, prove:

- **Correctness of every exact claim.** "Computes all Pareto-optimal journeys", "the shortcuts are sufficient", "returns the same result as Dijkstra".
- **That each pruning rule preserves correctness**, or state that it does not and measure the error.
- **Running time and space bounds** that you state.
- **Properties the algorithm relies on** (an invariant, a monotonicity, a dominance relation being transitive).

Do not prove:

- Things that are standard and cited. Cite them and restate the bound.
- Performance on real inputs. That is what the experiments are for.

## Statements

- Define every object before the statement. The statement uses only defined terms.
- Put all assumptions into the statement or the preliminaries. Examples from the route planning literature: the footpath graph is transitively closed and fulfills the triangle inequality; trips of one line do not overtake each other; departure buffer times are non-negative. If the proof uses an assumption, the reader must be able to find it.
- State exactly what is claimed. "For every Pareto-optimal journey J there is a journey J' with the same departure time, arrival time, and number of trips that uses only shortcut edges." Not "the shortcuts are sufficient".
- Distinguish weak and strict dominance, and say which one the statement uses. Tie handling is where correctness bugs hide. Arc-Flag TB found a correctness problem in the transfer precomputation of an earlier technique; such problems usually sit in the boundary cases.
- Bounds state their type: worst case, expected, amortized, with high probability (define it once).

## Proof patterns

### Invariant

For round-based and iterative algorithms. State the invariant before the algorithm, prove it by induction over rounds or iterations, and derive correctness from it at termination.

> **Invariant.** At the beginning of round k, the label of every stop v contains the earliest arrival time at v over all journeys with fewer than k trips.
>
> *Proof.* Induction over k. [Base case.] [Step: every journey with k trips consists of a journey with k − 1 trips, a transfer, and one trip; the round scans every route that contains a stop improved in round k − 1, so ...]

Write the step in terms of the algorithm's lines: "Line 8 relaxes ... ; hence ...".

### Contradiction with a minimal counterexample

For sufficiency claims (shortcuts, flags, precomputed transfers). ULTRA uses this form:

1. Assume a journey exists that needs something missing from the precomputed data and cannot be replaced by an equivalent journey.
2. Decompose it into the parts that the preprocessing handles (in ULTRA: consecutive pairs of trips, the *candidate journeys*).
3. One part must contain the missing element. Look at that part.
4. The preprocessing processed this part (it runs for every source stop). By the correctness of the underlying algorithm, it found either this part or something that dominates it.
5. Case 1: it found this part and stored the missing element. Case 2: it found a dominating part, which can replace this one in the journey. Both contradict the assumption.

Say why replacing a part keeps the whole journey valid and not worse. That step is often skipped and often wrong.

### Reduction to a known algorithm

"The query performs exactly the operations of [X] on the graph G'', so it is correct if G'' contains every edge that an optimal journey needs. Lemma 3 shows that it does." Name what is reused, then prove only the new part.

### Exchange or replacement argument

For dominance and pruning: "Let J use the pruned element. Then J' (constructed explicitly) does not use it, has the same departure time, does not arrive later, and uses no more trips. Hence J' weakly dominates J." Construct J' explicitly.

### Cost proofs

Split into parts and combine: "Lemma 4 bounds the work of phase 1, Lemma 5 that of phase 2. Combining them proves the theorem." For parallel algorithms, prove work and span separately.

## Running time

- Derive it next to the algorithm. Count the main loop's iterations and the cost per iteration.
- State it in the parameters the reader cares about (stops, trips, routes, stop events, rounds), not only n.
- Give the competitor's bound in the same parameters, so the comparison is direct.
- If the worst case is far from practice, say so and point to the experiments. Do not hide a bad worst case.

## Heuristics and optimizations

Many engineering steps change performance, not output. Say which kind each one is.

- **Correctness-preserving:** prove it, or reduce it to an existing proof. "This does not affect correctness, since every candidate is still processed."
- **Size-affecting but correct:** say what may get worse. ULTRA's stopping criterion "might cause some witnesses to be pruned and thus lead to superfluous shortcuts", but never misses a needed one.
- **Correctness-changing:** say so explicitly, name the condition under which answers are wrong, and measure how often (see `experiments.md`, Verification).

## Counterexamples

When a natural rule is incorrect, show it.

- Use the smallest instance that breaks the rule. Draw it.
- State the rule, the instance, the wrong output, and the correct output.
- A counterexample often motivates the actual rule better than prose.

## Layout

- Lemmas and theorems are numbered blocks (`theorem`, `lemma`, `observation` from `assets/paper-macros.tex`). Proofs end with the QED box.
- Before a long proof, one or two sentences of intuition: "Intuitively, every journey can be split at its intermediate transfers, and each piece is a two-trip journey that the preprocessing has seen."
- Long proofs go to an appendix. The main text keeps the statement, the intuition, and a pointer ("see Appendix A").
- Refer to pseudocode by line number. Keep the names in the proof identical to those in the pseudocode.
- Use "Observation" for facts that follow directly from definitions, "Lemma" for intermediate results, "Theorem" for main results.

## Checklist

- Every term in a statement is defined before it.
- Every assumption the proof uses is stated.
- Weak or strict dominance is explicit.
- Each case analysis says why it is exhaustive.
- No "clearly", "obviously", or "it is easy to see" covers a nontrivial step.
- Every pruning rule is either proved safe or labeled as changing results.
- Running time is stated in the same parameters as the competitors' bounds.
- No `\GAP` or `\TODO` is left in the final PDF.
