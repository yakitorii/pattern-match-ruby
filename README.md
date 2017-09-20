# Pattern match in Ruby

## About this project

This project is to try Pattern Matching in Ruby.
It's a conceptual model, and has many arguments about specification of pattern match.
Welcome to your feed back via issues or PR.


## How to build?

Before trying this feature, you need build customized Ruby interpreter. See https://github.com/ruby/ruby/  to build and install a ruby interpreter.

For Japanese language users [[MRI のビルド、およびインストール|https://github.com/ko1/rubyhackchallenge/blob/master/2_mri_structure.md#演習-mri-のビルドおよびインストール]] will help you.

## How to try?

Basic: use `%p` to write pattern and match operator is `=~`.

```
if %p([:ok, x]) =~ [:ok, 200]
   p "Seconnd Element is #{x}"
else
   p "Not Match!"
end

```


You can also use `===` as the alias of `=~`.

```
res = [:ng, 500]

case res
when %p([:ok, status])
  p "You got! status: #{status}"
when %p([:ng, status])
  p "Nooo! status: #{status}"
else
  raise "unexpected response!"
end
```

`%p` also allows hash.
`_` is ignored.

```
user = { name: 'yuki', from: 'Fukuoka' }

case user
when %p({name: name, from: 'Hiroshima'})
  p "#{name} is a local people. Thank you!"
when %p({name: name, from: _})
  p "#{name} is a visitor. welcome!"
end

```


You can write hash in array, and array as value of hash.
```
if %p( [x, :y, { "array" => [5, v]}] ) =~ [1, :y, { "array" => [5, 'a, b']}]
  p x
  p v
end
```

`%p` allows regexp too.
```
language = { name: 'pm-ruby', version: "development" }

case language
when %p({ name: /^pm-.*/, version: version })
  p "This pattern-match's version is #{version}"
when %p({ name: name, version: version })
  p "This #{name}'s version is #{version}"
end
```

and `_` + class name

```
obj = %w(a b c)

case obj
when %p(_String)
  p obj
when %p(_Array)
  p obj.join(',')
end
```

