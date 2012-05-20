class Format < ActiveRecord::Base
  extend SimpleSearch
  SEARCH_INCLUDES = %w{ }
  SEARCH_FIELDS = %w{ formats.name formats.mime_type formats.dataformat formats.notes }

  has_many :input_files

  named_scope :order, lambda { |order| {:order => order, :include => SEARCH_INCLUDES } }
  named_scope :search, lambda { |search| {:conditions => simple_search(search) } } 

  comma do
    id
    name
    mime_type
    dataformat 
    notes
    created_at
    updated_at
  end

  def name_mimetype
    "#{name} #{mime_type}"
  end
  def to_s
    name_mimetype
  end
  def select_default
    "#{id}: #{self}"
  end

  #Columns we search when referenced from another model
  #Fields present in 'select_default'
  def self.search_columns
    return ["formats.id", "formats.name", "formats.mime_type"]
  end
end
