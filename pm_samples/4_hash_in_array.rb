if %p( [x, :y, { "array" => [5, v]}] ) =~ [1, :y, { "array" => [5, 'a, b']}]
  p x
  p v
end
