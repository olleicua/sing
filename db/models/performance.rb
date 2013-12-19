class Performance < ActiveRecord::Base
  belongs_to :track
  belongs_to :performer, :class_name => :artist
  
  def roles
    role.slit /\s/
  end
end
