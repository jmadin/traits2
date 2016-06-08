class Precisiontype < ActiveRecord::Base
  belongs_to :user
  has_many :measurements, :dependent => :restrict_with_error

  validates :precision_type_name, :presence => true
  validates :precision_type_name, :uniqueness => true
end
