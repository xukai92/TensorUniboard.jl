# TensorUniboard: run TensorBoard in your terminal

This package uses UnicodePlots.jl to plot logs from TensorFlow in yout terminal.
It only contains a demo Julia file at the moment.
Please check my proof-of-concpet by
```julia
using TensorUniboard
linedatademo()
```

NOTE: you need to add this package first by `Pkg.add("https://github.com/xukai92/TensorUniboard.jl")`.

## Requirements

- Julia 0.7 (lower version may be compatible but is not tested)
- UnicodePlots.jl 0.3.1 (lower version may be compatible but is not tested)

## References

https://github.com/timholy/ProgressMeter.jl/blob/master/src/ProgressMeter.jl#L301-L305
https://stackoverflow.com/a/24493881
https://en.wikipedia.org/wiki/ANSI_escape_code#CUU
