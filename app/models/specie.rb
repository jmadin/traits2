class Specie < ActiveRecord::Base

  belongs_to :user
  has_many :observations, :dependent => :destroy
  has_paper_trail
  # validates :specie_name, :presence => true

  validates_uniqueness_of :specie_name, :allow_blank => true
  validates_uniqueness_of :aphia_id, :allow_blank => true
  validate :check_consistency

  has_many :synonyms, :dependent => :destroy
  accepts_nested_attributes_for :synonyms, :reject_if => :all_blank, :allow_destroy => true

  default_scope -> { order('specie_name ASC') }
  
  searchable do
    text :specie_name
    string :specie_name_sortable do 
      specie_name
    end
    text :synonyms do
      synonyms.map{ |synonym| synonym.synonym_name }
    end
  end

  def check_consistency
    errors.add(:base, 'Enter either species name or Aphia ID, or the Aphia ID you entered did not resolve') if (specie_name.blank? & aphia_id.blank?)
  end
    
end
