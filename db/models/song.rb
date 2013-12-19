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
