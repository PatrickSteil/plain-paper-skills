# Framing the contribution honestly

Contents: The goal, The contribution test, Calibrating claims, Strengths and weaknesses, Where limitations go, Tradeoffs, Comparing with prior work, Overselling patterns, Rewrites.

## The goal

A reader should finish the paper knowing four things: what the contribution does, which problem it solves, where it is better than the alternatives, and where it is worse. The paper is "simple" when these four things are easy to find and nothing is inflated.

Models for this tone:

- **Arc-Flag TB** (SEA 2023). The abstract says that other algorithms answer queries faster but need much more memory, positions the contribution as a tradeoff controlled by a parameter, and states that the algorithm currently answers a stated percentage of queries incorrectly, with the cause.
- **FLASH-TB** (journal version of the same work). The abstract describes the whole idea in three plain sentences before any result: partition the network, precompute one flag per cell and transfer, explore only flagged transfers.
- **ULTRA** (ESA 2019). The contribution starts from an observation that is reported as an observation (intermediate transfers are rarely relevant), and the experiments separate effects of the algorithm from effects of imperfect input data.

Even good papers sometimes write "novel", "extensive evaluation", or "significantly faster" without a test. Do not copy these habits.

## The contribution test

Before writing an abstract or introduction, write these four sentences for yourself. If one cannot be written, the paper is not ready to be framed.

1. **Does:** "[Name] computes X by doing Y." (Mechanism in plain verbs.)
2. **Solves:** "This removes limitation L of prior approaches, which comes from M." (Mechanism of the gap.)
3. **Better:** "On [instances], it is [ratio] faster / smaller than [strongest baseline] at [cost]."
4. **Worse:** "It needs [cost] / does not support [feature] / is slower than [algorithm] when [condition]."

Sentence 4 is not optional. Every algorithm engineering contribution has a cost (preprocessing time, space, restricted input model, weaker guarantee, harder implementation) or a regime where something else wins. If you cannot name one, you have not compared against the right baseline.

## Calibrating claims

Each claim needs evidence of the matching strength. Use the weakest wording that the evidence supports.

| Claim | Evidence needed | Otherwise write |
|---|---|---|
| "the first" | a scoped literature check, stated scope | "to the best of our knowledge, no algorithm for X in setting Y has done Z" |
| "faster than X" | a ratio on named instances, same hardware or stated difference | "comparable to X on [instance]", or omit |
| "scales to large inputs" | measurements at the large sizes | the largest size measured |
| "exact" / "correct" | a proof, or verification against a reference on all queries | "returned the same results as X on all N test queries" |
| "practical" | a measured cost acceptable for a stated use | the number itself |
| "general" / "works for any X" | a proof or experiments on several kinds of X | the kinds of X tested |
| "robust" | experiments over the parameter range | the range tested |
| "significantly" | a statistical test | a ratio, or nothing |
| "up to N times faster" | the full range is reported next to it | "between A and N times faster, depending on the instance" |

"Up to" alone is the most common inflation. It reports the best case as if it were typical. Give the range or the median.

## Strengths and weaknesses

State both in the same register. A strength is a measured or proved property; a weakness is too.

- Put the main weakness in the same paragraph as the main strength when they are two sides of one tradeoff: "Queries are 12 times faster than X. This costs 40 minutes of preprocessing and 2.1 GiB of additional space."
- Name the regime where a baseline wins: "For inputs below 2^14 elements, X is faster, because Y fits into the cache."
- If the algorithm solves a restricted problem, say so where the problem is defined, not only in the conclusion.
- Do not soften a weakness with a promise. "Future work could remove this restriction" is fine in the conclusion; it does not belong next to the weakness as a counterweight.
- Do not frame a weakness as a strength ("our algorithm deliberately ignores X"). If ignoring X was a choice, give the reason and its cost.

## Where limitations go

| Kind of limitation | Where it appears |
|---|---|
| Changes what the algorithm solves (restricted input, heuristic, wrong answers in some cases) | abstract, introduction (contribution paragraph), problem definition, experiments, conclusion |
| A cost of the approach (preprocessing, space) | abstract if it is the main tradeoff; experiments; conclusion |
| A regime where a baseline wins | experiments, where it is measured; conclusion |
| Data quality issues | instances paragraph and wherever they affect a result |
| Threats to validity of the experiments (synthetic data, one machine, small query set) | setup or instances; once more where a conclusion depends on it |

A limitation that changes the answer to "what does it solve" must be in the abstract. Arc-Flag TB states its error rate in the abstract. That is the standard.

## Tradeoffs

Many algorithm engineering contributions are a point on a tradeoff curve, not a winner on every axis. Present them that way.

- Show the curve, not one configuration: a parameter sweep with time against space (the paper-figures skill has a tradeoff-plot template).
- Keep the baselines that dominate in one axis in the plot and the table, including the one that is faster than everything you have.
- State which region of the tradeoff is new: "No previous technique answers queries below 1 ms with less than 1 GiB on this network."
- Do not call a point on a curve "the best of both worlds".

## Comparing with prior work

- Describe prior work at its best: its strongest variant, its intended setting, its published numbers. A weak description of a baseline makes your result look better and the paper look worse.
- When you reimplement a baseline, say so and say what optimizations it received. Give it the same engineering effort.
- If a baseline solves an easier or harder problem, mark it in the table (marker columns) and say so in the text: "Note that CSA solves an easier problem than RAPTOR, since it does not minimize the number of transfers."
- If you find a problem in prior work, state it as a fact with evidence, without commentary on the authors. Give them credit for what works.
- Credit the source of your key observation. If the idea comes from a preliminary study, a thesis, or a discussion, cite it.

## Overselling patterns

Remove these when you see them.

| Pattern | Why it oversells | Fix |
|---|---|---|
| Title promises more than the paper ("Efficient X for all Y") | the paper covers some Y | name the setting: "X for Y with Z" |
| Speedup against a weak or unoptimized baseline | inflates the ratio | compare against the strongest baseline; report the weak one only as context |
| Best instance in the abstract, others in an appendix | best case read as typical | give the range or all main instances |
| Average only, when the distribution is skewed | hides slow cases | add median and a high percentile, or a rank plot |
| Plot whose y axis starts at the minimum value | a 5 % gap looks like a factor | start at 0, or state the ratio in the text |
| Linear x axis where your algorithm looks best at the large end | hides the small inputs | log axis over the full range |
| Leaving out the baseline that wins | false impression of dominance | keep it, mark what it costs |
| "Our approach can be extended to ..." without doing it | a claim without evidence | move to future work as an open question |
| Long list of "advantages" in the introduction | repetition reads as advertising | one sentence per property, each checkable |
| Conclusion that repeats claims more strongly than the experiments showed | drift | write the conclusion from the experiments section, not from the abstract |

## Rewrites

Inflated: "We present a novel, highly efficient framework that significantly outperforms the state of the art."
Plain: "We present [Name], which [mechanism]. On [instances], its queries are [A] to [B] times faster than [baseline], at the cost of [preprocessing / space]."

Inflated: "Our approach seamlessly handles arbitrary transfer modes."
Plain: "We evaluated walking, cycling, and car transfers. Preprocessing stayed below [time] for all of them."

Inflated: "While [Baseline] is faster, it requires prohibitive memory."
Plain: "[Baseline] answers queries [ratio] faster but needs [space] on [instance], compared to [space] for [Name]."

Inflated: "Experiments demonstrate the practicality of our approach."
Plain: state the measured time and space and let the reader judge practicality.
