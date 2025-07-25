# Do more trees mean more money?
Are houses more expensive on streets with tall trees compared to those with shorter trees? Let's find out!

### Important!
Your code will be reviewed by a member of our engineering team (we share the work). The exercise itself is straightforward, no tricky algorithms or obscure data structures to worry about. It's based on real-world problems we often encounter.

### Write your best code
Focus on producing high-quality code — easy to read and easy to maintain. Only as complicated as it needs to be. If this was a pull request to a teammate, you're aiming for zero comments. As professional as possible.
There is **no time limit**. The time it took you to complete the task is not considered when we evaluate. We only consider the points below.

## Evaluation
These points are used by the engineering team to evaluate submissions.

- The exercise is packaged as a single `zip` file.
- There is a `README` (text or markdown) at the top-level of the `zip` with all of the instructions required to build, run and test.
- There are unit tests.
- Variable and functions are well named, with no generic names — e.g. `parse_price()` not `process()`.
- Code is well structured, generally functions only do one thing (and do it well):
  - Tests can cover the important steps of the exercise, rather than tests that need to execute everything end-to-end.
  - This is a short, well-contained problem. The architecture should be similarly straight-forward with minimal complexity.
  - Error handling is appropriate for use as a library — could someone re-use portions of this codebase and be confident in the correctness of the answers produced?
- Logic is implemented in an appropriate place for production-ready code. E.g. if this is Ruby code, it's not appropriate for all the processing logic to be implemented in SQLite calls.
- Dependencies are appropriate for production-ready code.
- Only code related to the question is reviewed. Fancy HTML presentation, container configuration, etc. must be ignored — it's not part of the question.

## Datasets
We have two files: [`dublin-trees.json`](./dublin-trees.json) and [`dublin-property.csv`](./dublin-property.csv`):
- [`dublin-trees.json`](./dublin-trees.json) contains a list of street names. Streets are split into two categories: `short` and `tall`, based on the median tree height as recorded by Dublin City Council.
- [`dublin-property.csv`](./dublin-property.csv`) contains a subset of the Residential Property Price Register, with a list of property addresses, their street name and sale price in euro.

We've cleaned the datasets a little, so the street name in [`dublin-trees.json`](./dublin-trees.json) exactly matches the `Street Name` column in [`dublin-property.csv`](./dublin-property.csv`).

### `dublin-trees.json` structure
There are two top-level entries: `short` and `tall`.

Street names are in an arbitrarily nested structure, only the entry with a height is relevant and this entry contains the complete street name.

Here's an example:
```json
        {
            "short": {
                "drive": {
                    "abbey": {
                        "abbey drive": 0
                    },
                    "coolrua": {
                        "coolrua drive": 10
                    },
                    "coultry": {
                        "coultry drive": 5
                    },
                }
            },
            "tall": {
                "gardens": {
                    "temple": {
                        "temple gardens": 20
                    }
                },
                "bramblings": {
                    "the": {
                        "the bramblings": 20
                    }
                },
            }
        }
```

The "short tree" street names in this example are:
- abbey drive
- coolrua drive
- coultry drive

and the "tall tree" street names are:
- temple gardens
- the bramblings

## Your task
Write a program that takes these files and outputs the average cost of a property:
- on a street with tall trees
- on a street with short trees

We might want to run this program as part of some larger system, so your code should not require any user input or any user interaction once it starts.

We recommend you write your answer in the language you're most comfortable working in. You can use open source libraries, tools in the standard library, search Google, StackOverflow, etc. -- anything you might do in a real day-to-day production programming task.

### We'd like:
- Your code to be as close to "production ready" as possible.
- A minimal set of unit tests (does not need to be comprehensive, but confident we'd catch a logic bug in some future change).
- A `README` with the basic instructions you'd give another developer to run your code.

Please package your code in a single zip file.

If you have any questions, please let us know.

## Recommended reading
These two articles are referenced in our internal coding standards and practices wiki. They give a good idea of how we think about code. You don't have to read them, but they might help:
- [A Guide to Naming Variables](https://a-nickels-worth.dev/papers/varnaming/)
- [Cognitive load is what matters](https://minds.md/zakirullin/cognitive)

# Original datasets
Please use the files we've supplied for this exercise, as we've tweaked them slightly to make things easier. The original datasets come from:
- [Dublin City Council's tree data](https://data.smartdublin.ie/dataset/tree-dcc)
- [Ireland's Residential Property Price Register](https://www.propertypriceregister.ie)
