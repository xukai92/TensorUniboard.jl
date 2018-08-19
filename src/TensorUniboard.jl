module TensorUniboard

import Base: push!, getindex, length, show
export demo, EventAccumulator

using UnicodePlots

abstract type Data end
abstract type DataGroup end

include("core.jl")
include("event.jl")
include("linedata.jl")
include("panel.jl")

function demo(ea::EventAccumulator)

  reload!(ea)

  name1 = "dialog_loss"
  data1 = scalars(ea, name1)
  name2 = "dialog_feature_loss_sentence"
  data2 = scalars(ea, name2)

  x1 = map(t -> Float64(t[2]), data1)
  y1 = map(t -> Float64(t[3]), data1)
  x2 = map(t -> Float64(t[2]), data2)
  y2 = map(t -> Float64(t[3]), data2)

  ld1 = LineData("run1")
  ldg1 = LineDataGroup([ld1], name1)
  ld2 = LineData("run1")
  ldg2 = LineDataGroup([ld2], name2)
  panel = Panel([ldg1, ldg2])
   
  for i = 1:length(data1)
    push!(ldg1[1], x1[i], y1[i])
    push!(ldg2[1], x2[i], y2[i])
    ps = show(panel)
    sleep(0.5)
    clean(ps)
 end
end

end # module
