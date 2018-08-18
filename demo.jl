using UnicodePlots
import Base: push!

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

ld1 = LineData("sin")
ld2 = LineData("cos")

for i = 1:length(data_x)
  push!(ld1, data_x[i], data_y1[i])
  push!(ld2, data_x[i], data_y2[i])
  # TODO: implement ignore extreme
  x_min = min(ld1.x..., ld2.x...)
  x_max = max(ld1.x..., ld2.x...)
  y_min = min(ld1.y..., ld2.y...)
  y_max = max(ld1.y..., ld2.y...)
  p = lineplot(ld1.x, ld1.y, name=ld1.name,
               xlim=[x_min, x_max], ylim=[y_min, y_max],
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
