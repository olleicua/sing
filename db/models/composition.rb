class Composition < ActiveRecord::Base
  belongs_to :song
  belongs_to :composer, :class_name => :artist
  
  def roles
    role.slit /\s/
  end
end
