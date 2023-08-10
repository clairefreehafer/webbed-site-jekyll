require 'yaml'
require 'date'

currently_reading_path = './_data/books/currently_reading.yml'
read_path = './_data/books/read.yml'

currently_reading = YAML.load_file(currently_reading_path, permitted_classes: [Date])
read = YAML.load_file(read_path, permitted_classes: [Date])

for book in currently_reading
  if book['finished'] then
    currently_reading.delete(book)
    read.unshift(book)
  end
end

# sort read by finished date
read.sort_by! { |book| book['finished'] }.reverse!

puts read

File.write(currently_reading_path, currently_reading.to_yaml)
File.write(read_path, read.to_yaml)