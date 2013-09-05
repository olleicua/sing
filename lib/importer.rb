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
      else
        nil
      end
    end.flatten.compact
  end
  
  def import file
    # TODO: implement me
  end
end