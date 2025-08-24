# `escardo`

a minimal haskell demonstration of [Infinite sets that admit fast exhaustive search](https://martinescardo.github.io/papers/exhaustive.pdf) with syntatic modulus extraction and a probabilistic variant. blog coming soon.

### Usage

```bash
cabal build
cabal run escardo       # run examples
cabal run benchmark     # run benchmarks
```
Variants: 
    - `sme`: syntactic modulus extraction
    - `escardo`: the normal Escardo exhaustive deterministic search 
    - `prob`: my probabilistic variant of Escardo search
