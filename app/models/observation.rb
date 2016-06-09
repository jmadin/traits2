class Observation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  belongs_to :specie
  belongs_to :resource
  alias_attribute :resource_secondary, :resource

  has_many :measurements, dependent: :destroy, before_add: :set_nest
  accepts_nested_attributes_for :measurements, reject_if: :all_blank, allow_destroy: true
  
  has_many :issues, :dependent => :destroy

  has_paper_trail
  
  scope :order_species, -> { 
    joins(:specie).order('species.specie_name ASC') 
  }
  
  scope :remove_hidden, -> { 
    where.not(id: joins(measurements: :trait).where('traits.hide is true')) 
  }

  validates :user, presence: true
  validates :location, :presence => true
  validates :specie, :presence => true
  validates :measurements, :presence => true

  validates :resource, presence: { message: "is required for public observations. Turn observation access off if the data are unpublished." }, if: :access?

  searchable do
    boolean :access  
    integer :user_id  
    text :measurements do
      measurements.map{ |measurement| measurement.value }
    end
  end
  

  def set_nest(item)
    item.observation ||= self
  end
  
end
