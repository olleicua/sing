sing
====

A CLI music player built on top of mplayer and activerecord


development status
====

Sing is currently in development.  The activerecord models have been built up in
`db/create.rb` and `db/setup.rb`.  The import command which will recursively search
for supported music files in a directory and prompt the user to organize them
is being built up in `lib/importer.rb`.

console
====

If you use [pry](http://pryrepl.org/) then you can add the following to your
.pryrc file and then when you run pry from the sing's source directory it will load
up active record:

```ruby
singdb = File.join Dir.getwd, 'db/setup.rb'
sing = File.join Dir.getwd, 'sing'
load sing if File.exist?(sing) and File.exist?(singdb) and ENV['SKIP_SING'].nil?
```