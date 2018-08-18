using UnicodePlots

clean_line_and_cursor_up(n) = (for _ = 1:n print("\r\e[K\e[A") end)

x_start = 0
x_end = 5
data_x = 0:0.1:5
data_y1 = sin.(data_x)
data_y2 = cos.(data_x)

# Simulate data stream
x1 = Float64[]
y1 = Float64[]
x2 = Float64[]
y2 = Float64[]

for i = 1:length(data_x)
    push!(x1, data_x[i])
    push!(y1, data_y1[i])
    push!(x2, data_x[i])
    push!(y2, data_y2[i])
    # TODO: implement ignore extreme
    p = lineplot(x1, y1,
                 name="sin", grid=false,
                 width=60, height=25)
    lineplot!(p, x2, y2, name="cos")
    title!(p, "demo")
    show(p)
    p_str = string(p)
    # TODO: find a more efficient way to get the plot height
    p_height = length(split(p_str, "\n")) - 1
    #  p_height = nrows(p.graphics)  # this should be fast but it doesn't include rows for border, title, etc
    sleep(0.5)
    clean_line_and_cursor_up(p_height)
end
