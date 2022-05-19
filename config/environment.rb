# Load the Rails application.
require_relative 'application'

require 'base_ext'
# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:ctdb_date] = "%e %B %Y at %I:%M %p"
Time::DATE_FORMATS[:ctdb_date2] = "%e %B %Y"
