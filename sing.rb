SingRoot = File.expand_path File.dirname __FILE__

def singroot file
  File.join SingRoot, file
end

require singroot 'db/setup.rb'
require singroot 'lib/importer.rb'
