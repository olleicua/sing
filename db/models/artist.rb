class Artist < ActiveRecord::Base
  
  has_many :performances
  has_many :compositions
  has_many :tracks, :through => :performances
  has_many :songs, :through => :compositions
  
  def albums
    tracks.map(&:album)
  end
  
  def performance_roles
    performances.map(&:roles).flatten.uniq
  end
  
  def composition_roles
    compositions.map(&:roles).flatten.uniq
  end
  
  def roles
    (performance_roles + composition_roles).uniq
  end
  
  def cocomposers
    songs.map(&:composers).flatten.uniq.reject do |artist|
      artist == self
    end
  end
  
  def coperformers
    tracks.map(&:performers).flatten.uniq.reject do |artist|
      artist == self
    end
  end
  
  def genres
    (songs.map(&:genres) + tracks.map(&:genres)).flatten.uniq
  end
end
