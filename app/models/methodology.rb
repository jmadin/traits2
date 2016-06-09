class Methodology < ActiveRecord::Base

  belongs_to :user
  has_many :measurements

  validates :methodology_name, :presence => true
  
  default_scope -> { order('methodology_name ASC') }

  searchable do
    text :methodology_name  
    string :methodology_name_sortable do 
      methodology_name
    end
  end

end
