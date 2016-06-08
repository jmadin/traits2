class Traitclass < ActiveRecord::Base
  belongs_to :user
  has_many :traits, :dependent => :restrict_with_error

  validates :class_name, :presence => true
  validates :class_name, :uniqueness => true

  # default_scope -> { order('class_name ASC') }

  searchable do
    string :class_name
  end

end
