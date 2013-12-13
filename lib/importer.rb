require singroot 'lib/file_import.rb'

class Importer; end

class << Importer
  
  SUPPORTED_EXTENTIONS = %w( mp3 wav mp4 )
  
  def run directory
    files(directory).each do |file|
      import file
    end
  end
  
  def files directory
    Dir.entries(directory).map do |file|
      path = File.join(directory, file)
      if file =~ /^\./
        nil
      elsif SUPPORTED_EXTENTIONS.include? file.split('.').last.downcase
        path
      elsif File.directory? file
        files path
      elseX2
        nil
      end
    end.flatten.compact
  end
  
  
  def import path
    file = FileImport.new path
    puts "Importing #{file} .."
    track = Track.create(:file => File.basename(path))
    
    {
      :track_number => file.metaData['Track name/Position'],
      :original => nil,
      :bytes => file.fileSize,
      :seconds => file.duration
    }.each_pair do |attr, default|
      print "track.#{attr} (#{default}): "
      value = gets.strip
      value = default if value.empty?
      track.update_attribute(attr, value)
    end
    
    # TODO: implement me
  end
end