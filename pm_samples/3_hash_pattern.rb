user = { name: 'yuki', from: 'Fukuoka' }

case user
when %p({name: name, from: 'Hiroshima'})
  p "#{name} is a local people. Thank you!"
when %p({name: name, from: _})
  p "#{name} is a visitor. welcome!"
end
