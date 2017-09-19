language = { name: 'pm-ruby', version: "development" }

case language
when %p({ name: /^pm-.*/, version: version })
  p "This pattern-match's version is #{version}"
when %p({ name: name, version: version })
  p "This #{name}'s version is #{version}"
end

