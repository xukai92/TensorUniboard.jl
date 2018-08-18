struct Panel
  data_group_arr::Vector{<:DataGroup}
end

function show(panel::Panel)
  ps = map(plot, panel.data_group_arr)
  for p in ps
    show(p)
  end
  return ps
end
