class Mash < ActiveRecord::Base
  belongs_to :use, :class_name => :song
  belongs_to :component, :class_name => :song
end
