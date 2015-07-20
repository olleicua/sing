require 'shellwords'

class FileImport
  def initialize path
    @path = path
    @shellpath = Shellwords.escape path
  end
  
  def metaData
    @metaData ||= Hash[`mediainfo #{@shellpath}`.split(/\n/).map do |line|
                         [$1.strip, $2.strip] if line =~ /^([^:]+):(.+)$/
                       end.compact]
  end
  
  def fileSize
    @fileSize ||= `du -b #{@shellpath}`.split(/\s/).first
  end
  
  def duration
    @duration ||= if /(\d+)mn.*(\d+)s/.match(metaData['Duration'])
                    ($1.to_i * 60) + $2.to_i
                  else
                    nil
                  end
  end
  
end