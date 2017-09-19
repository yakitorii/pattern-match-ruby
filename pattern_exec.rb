json = JSON.parse %q|{"status":"ok","users":[{"name":"Yuki","roll":"mather"},{"name":"ko1","roll":"father"},{"name":"panda","roll":"baby"}]}|

if %p{ {"status" => "ok",  "users" => users } } =~ json
  p users
end

__END__
obj = 1
if %p(_Integer) =~ obj
  p 'it is integer'
else
  p 'it is not integer'
end

obj = 'a'
if %p(_Integer) =~ obj
  p 'it is integer'
else
  p 'it is not integer'
end

user = { name: 'yuki', from: 'Fukuoka' }
case user
when %p({name: name, from: 'Hiroshima'})
  p "#{name} is a local people. Thank you!"
when %p({name: name, from: _})
  p "#{name} is a visitor. welcome!"
end

if %p([:ok, x]) =~ [:ok, 200]
   p "Seconnd Element is #{x}"
else
   p "Not Match!"
end

if %p([:ok, x]) =~ [:ng, 500]
   p "Seconnd Element is #{x}"
else
   p "Not Match!"
end

if %p(:p) =~ :p
  p "symbol succss"
end

res = {status: 'ok', name: 'ko1'}
if %p({status: 'ok', name: name}) =~ res
  p name
else
  raise 'error!'
end

if %p({:status => 'ok', :name => name}) =~ res
  p name
else
  raise 'error!'
end

if %p([x, :y, { :test => z, "array" => [5, v]}]) =~ [1, :y, { test: 3, "array" => [5, 'a, b']}]
  p x
  p z
  p v
end

if %p( [x, :y, { :test => z, "a" => 1 }] ) =~ [1, :y, { test: 3, "a" => 1}]
  p x
  p z
end

__END__

if %p([x, :y, [z, "a, b"]]) =~ [1, :y, [5, "a, b"]]
  p x
  p z
end



__END__

if %p({x: z, y: _}) =~ {x: 7, y: 8}
  p 'success!'
  p y
end

if %p([x, :x, [[y], z]]) =~ [1, :x, [[5], 4]]
  p 'success! 2'
  p y
  p z
end


__END__

# PatternMatch.save_binding(binding)

y = nil
if (PatternMatch.save_binding(binding); PatternMatch.new("[1, :x, y]")) =~ [1, :x, 5]
  p y #=> :y
end

