obj = %w(a b c)

if %p([_String, _String, _String]) =~ obj
  p obj.join(',')
end
