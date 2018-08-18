module TensorUniboard

import Base: push!, getindex, length, show
export demo

using UnicodePlots

abstract type Data end
abstract type DataGroup end

include("core.jl")
include("linedata.jl")
include("panel.jl")

function demo()
  x_start = 0
  x_end = 5
  data_x = 0:0.1:5
  data_y1 = sin.(data_x)
  data_y2 = cos.(data_x)

  ld1 = LineData("sin")
  ldg1 = LineDataGroup([ld1], "1")
  ld2 = LineData("cos")
  ldg2 = LineDataGroup([ld2], "g2")
  panel = Panel([ldg1, ldg2])
   
  for i = 1:length(data_x)
    push!(ldg1[1], data_x[i], data_y1[i])
    push!(ldg2[1], data_x[i], data_y2[i])
    ps = show(panel)
    sleep(0.5)
    clean(ps)
 end
end

end # module
