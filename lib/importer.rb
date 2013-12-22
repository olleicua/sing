require singroot 'lib/file_import.rb'

class Importer; end

class << Importer
  
  SUPPORTED_EXTENTIONS = %w( .mp3 .wav .mp4 )
  
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
      elsif File.directory? file
        files path
      elsif SUPPORTED_EXTENTIONS.include? File.extname(file)
        path
      else
        nil
      end
    end.flatten.compact
  end
  
  
  def import path
    file = FileImport.new path
    puts "Importing #{path} .."
    track = Track.create(:file => path,
                         :track_number => file.metaData['Track name/Position'],
                         :original => nil,
                         :bytes => file.fileSize,
                         :seconds => file.duration)
    
    # TODO: implement me
  end
end