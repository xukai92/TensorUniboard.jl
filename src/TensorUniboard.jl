module TensorUniboard

import Base: push!, getindex, length
export demo

using UnicodePlots

abstract type Data end
abstract type DataGroup end

include("core.jl")
include("linedata.jl")

function demo()
  x_start = 0
  x_end = 5
  data_x = 0:0.1:5
  data_y1 = sin.(data_x)
  data_y2 = cos.(data_x)

  ld1 = LineData("sin")
  ld2 = LineData("cos")
  ldg = LineDataGroup([ld1, ld2], "demo")
   
  for i = 1:length(data_x)
    push!(ldg[1], data_x[i], data_y1[i])
    push!(ldg[2], data_x[i], data_y2[i])
    p = plot(ldg)
    show(p)
    sleep(0.5)
    clean_plot(p)
 end
end

end # module
