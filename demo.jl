using UnicodePlots

move_cursor_up(n) = (for _ = 1:n print("\r\e[A") end)

x_start = 0
x_end = 5
data_x = 0:0.1:5
data_y = sin.(data_x)

# Simulate data stream
x = Float64[]
y = Float64[]

for i = 1:length(data_x)
    push!(x, data_x[i])
    push!(y, data_y[i])
    p = lineplot(x, y,
                 title="demo", name="sin", grid=false,
                 #  xlim=[x_start, x_end], ylim=[-1, 1], # TODO: implement ignore extreme
                 width=60, height=25)
    show(p)
    p_str = string(p)
    # TODO: find a more efficient way to get the plot height
    p_height = length(split(p_str, "\n")) - 1
    move_cursor_up(p_height)
    sleep(0.5)
end
