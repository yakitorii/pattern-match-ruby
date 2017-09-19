res = [:ng, 500]

case res
when %p([:ok, status])
  p "You got! status: #{status}"
when %p([:ng, status])
  p "Nooo! status: #{status}"
else
  raise "unexpected response!"
end
