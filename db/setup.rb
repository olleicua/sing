require('./connect.rb')

class Track < ActiveRecord::Base
  belongs_to :song
  has_many :performances
  has_many :preformers, :through => :performances
  belongs_to :album
  
  def cover?; !original; end
  delegate :mashup, :to => :song
  
  def bit_rate
    8 * bytes.to_f / seconds.to_f
  end
  
  def beat_rate
    beats.to_f / second.to_f
  end
  
  def genres
    labels.split /\s/
  end
  
  def art
    attachments.split /n/
  end
end

class Song < ActiveRecord::Base
  has_many :tracks
  has_many :compositions
  has_many :composers, :through => :compositions
  
  # mashups
  has_many :use_mashes, :class_name => :mashes, :foreign_key => :component_id
  has_many :component_mashes, :class_name => :mashes, :foreign_key => :use_id
  has_many :uses, :through => :use_mashes
  has_many :components, :through => :component_mashes
  
  def mashup?
    components.count > 1
  end
  
  def original
    tracks.detect(&:original)
  end
  
  delegate :genres, :to => :original
  
  def all_tracks
    tracks + uses.map(:tracks).flatten
  end
  
  def inspired_tracks
    tracks.reject(&:original) + uses.map(:tracks).flatten
  end
end 

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

class Performance < ActiveRecord::Base
  belongs_to :track
  belongs_to :performer, :class_name => :artist
  
  def roles
    role.slit /\s/
  end
end

class Composition < ActiveRecord::Base
  belongs_to :song
  belongs_to :composer, :class_name => :artist
  
  def roles
    role.slit /\s/
  end
end

class Mash < ActiveRecord::Base
  belongs_to :use, :class_name => :song
  belongs_to :component, :class_name => :song
end
