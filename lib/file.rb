class FileImport
  def initialize path
    @path = path
  end
  
  def metaData
    @metaData ||= Hash[ `mediainfo #{@path}`\
                          .split(/\n/)\
                          .map{|l| l.split(':')}\
                          .flatten\
                          .map(&:strip) ]
  end
  
  def fileSize
    @fileSize ||= `du -b #{@path}`.split(/\s/).first
  end
  
  def duration file
    @duration ||= if /(\d+)mn.*(\d+)s/.match(metaData['Duration'])
                    ($1.to_i * 60) + $2.to_i
                  else
                    nil
                  end
  end
  
end