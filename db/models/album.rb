class Album < ActiveRecord::Base
  has_many :tracks
  
  def art
    attachments.split /\n/
  end
  
  def performers
    tracks.performers.flatten.uniq
  end
  
  def composers
    tracks.composers.flatten.uniq
  end
  
  def artists
    (performers + composers).uniq
  end
  
  def genres
    tracks.map(&:genres).flatten.uniq
  end
end
