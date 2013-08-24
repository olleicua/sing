ActiveRecord::Base.establish_connection(:adapter  => 'sqlite3',
                                        :database => 'test.db')

ActiveRecord::Schema.define do
  create_table :tracks do |t|
    t.column :track_number, :integer
    t.column :original, :boolean
    t.column :bytes, :integer
    t.column :beats, :integer
    t.column :seconds, :integer
    t.column :labels, :text
    t.column :attachments, :text
    t.column :notes, :text
    
    t.column :song_id, :integer
    t.column :album_id, :integer
    
    t.column :recorded_at, :date
    t.timestamps
  end
  
  create_table :songs do |t|
    t.column :title, :string
    t.column :lyrics, :text
    t.column :notes, :text
    
    t.column :composed_at, :date
    t.timestamps
  end
  
  create_table :artists do |t|
    t.column :name
    t.column :stage_name
    t.column :notes, :text
    
    t.timestamps
  end
  
  create_table :albums do |t|
    t.column :name, :string
    t.column :attachments, :text
    
    t.column :published_at
    t.timestamps
  end
  
  create_table :performances do |t|
    t.column :role, :string
    
    t.column :track_id, :integer
    t.column :performer_id, :integer
    
    t.timestamps
  end
  
  create_table :compositions do |t|
    t.column :role, :string
    
    t.column :song_id, :integer
    t.column :composer_id, :integer
    
    t.timestamps
  end
  
  create_table :mashes do |t|
    t.column :use_id, :integer
    t.column :component_id, :integer
    
    t.timestamps
  end
end
