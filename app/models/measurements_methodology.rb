class MeasurementsMethodology < ActiveRecord::Base
  belongs_to :measurement, :dependent => :destroy
  belongs_to :methodology, :dependent => :destroy
end
