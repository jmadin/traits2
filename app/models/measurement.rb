class Measurement < ActiveRecord::Base
  belongs_to :user
  belongs_to :trait
  belongs_to :standard
  belongs_to :valuetype
  belongs_to :precisiontype
  belongs_to :methodology

  belongs_to :observation
  # has_many :measurements_methodologies
  # has_many :methodologies, :through => :measurements_methodologies
  # accepts_nested_attributes_for :measurements_methodologies, reject_if: :all_blank, allow_destroy: true

  has_paper_trail
  
  # default_scope joins(:trait).order('traits.trait_class ASC, traits.trait_name ASC, created_at ASC').readonly(false)
  
  validates :trait, :presence => true
  validates :standard, :presence => true
  validates :value, :presence => true
  
  private

    def check_duplicates
      puts 'checking duplication'
      puts self.observation
      observations = Observation.where( :specie_id => self.observation.specie_id, :resource_id => self.observation.resource_id).joins(:measurements).where('measurements.trait_id = ? AND measurements.standard_id = ? AND measurements.value LIKE ?', self.trait_id, self.standard_id, self.value)      
      if observations.count > 1
        puts "there is a duplicate value"
        observations.each do |obs|
          errors.add(:observation, "Duplicate Value Exists. Check Observation : " + obs.id.to_s)
        end
        false
      end
      true
    end

end
