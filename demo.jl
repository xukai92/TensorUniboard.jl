using UnicodePlots
import Base: push!, getindex

clean_line_and_cursor_up(n) = (for _ = 1:n print("\r\e[K\e[A") end)

x_start = 0
x_end = 5
data_x = 0:0.1:5
data_y1 = sin.(data_x)
data_y2 = cos.(data_x)

# Simulate data stream
struct LineData
  x::AbstractVector{<:Number}
  y::AbstractVector{<:Number}
  name::AbstractString
end
LineData(name) = LineData(Float64[], Float64[], name)
push!(ld::LineData, x::Float64, y::Float64) = (push!(ld.x, x); push!(ld.y, y))

struct LineDataGroup
  line_data_arr::Vector{LineData}
end
getindex(ldg::LineDataGroup, idx::Int) = ldg.line_data_arr[idx]
get_x_mat(ldg::LineDataGroup) = cat(map(ld -> ld.x, ldg.line_data_arr)..., dims=[2])
get_y_mat(ldg::LineDataGroup) = cat(map(ld -> ld.y, ldg.line_data_arr)..., dims=[2])

function get_xlim(ldg::LineDataGroup)
  x_mat = get_x_mat(ldg)
  x_min = min(x_mat...)
  x_max = max(x_mat...)
  return [x_min, x_max]
end
function get_ylim(ldg::LineDataGroup)
  y_mat = get_y_mat(ldg)
  y_min = min(y_mat...)
  y_max = max(y_mat...)
  return [y_min, y_max]
end

ld1 = LineData("sin")
ld2 = LineData("cos")
ldg = LineDataGroup([ld1, ld2])
 
for i = 1:length(data_x)
  push!(ldg[1], data_x[i], data_y1[i])
  push!(ldg[2], data_x[i], data_y2[i])
 # TODO: implement ignore extreme
  p = lineplot(ld1.x, ld1.y, name=ld1.name,
               xlim=get_xlim(ldg), ylim=get_ylim(ldg),
               grid=false, width=60, height=25)
  lineplot!(p, ld2.x, ld2.y, name=ld2.name)
  title!(p, "demo")
  show(p)
  p_str = string(p)
  # TODO: find a more efficient way to get the plot height
  p_height = length(split(p_str, "\n")) - 1
  #  p_height = nrows(p.graphics)  # this should be fast but it doesn't include rows for border, title, etc
  sleep(0.5)
  clean_line_and_cursor_up(p_height)
end
