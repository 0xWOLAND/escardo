# `escardo`

a minimal haskell demonstration of [Infinite sets that admit fast exhaustive search](https://martinescardo.github.io/papers/exhaustive.pdf) with syntatic modulus extraction and a probabilistic variant. blog coming soon.

### Usage

```bash
cabal build
cabal run escardo       # run examples
cabal run benchmark     # run benchmarks
```
#### cli options: 
- `sme`: syntactic modulus extraction
- `escardo`: the normal Escardo exhaustive deterministic search 
- `prob`: my probabilistic variant of Escardo search

### Benchmarks

on my 2024 m4 macbook pro: 

Algorithm | Predicate | Time (s) | Result
----------|-----------|----------|-------
Escardo   | simple    | 0.001359 | Found
Prob-1K   | simple    | 0.000680 | 0.639
Escardo   | complex   | 0.000002 | Found
Prob-1K   | complex   | 0.000001 | 0.533
Escardo   | deep      | 0.000002 | Found
Prob-1K   | deep      | 0.000000 | 0.532
Escardo   | superComplex | 0.000003 | Found
Prob-1K   | superComplex | 0.000000 | 0.862