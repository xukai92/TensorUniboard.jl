function clean_line_and_cursor_up(n::Int) 
  for _ = 1:n 
    print("\r\e[K\e[A") 
  end
  print("\e[K]")  # need to clean the most top line
end

function clean(p::Plot)
  p_str = string(p)
  # TODO: find a more efficient way to get the plot height
  p_height = length(split(p_str, "\n")) - 1
  # The function below should be fast but it doesn't include rows for border, title, etc
  #  p_height = nrows(p.graphics)  
  clean_line_and_cursor_up(p_height)
end

clean(ps) = map(clean, ps)
