obj = %w(a b c)

case obj
when %p(_String)
  p obj
when %p(_Array)
  p obj.join(',')
end
