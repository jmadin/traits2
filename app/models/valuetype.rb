class Valuetype < ActiveRecord::Base
  belongs_to :user
  has_many :measurements, :dependent => :restrict_with_error
  
  validates :value_type_name, :presence => true
  validates :value_type_name, :uniqueness => true

end
