class MeasurementsMethodology < ActiveRecord::Base
  belongs_to :measurement
  belongs_to :methodology
end
