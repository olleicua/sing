require singroot 'db/connect.rb'

Dir.new(singroot 'db/models').select do |file|
  file.match(/^[^.].*\.rb$/)
end.each do |file|
  require singroot File.join('db/models', file)
end
