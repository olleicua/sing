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
