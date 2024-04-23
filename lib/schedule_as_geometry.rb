# frozen_string_literal: true

require 'rgeo'

require_relative 'schedule_as_geometry/version'
require_relative 'schedule_as_geometry/quoting'
require_relative 'schedule_as_geometry/geometry'
require_relative 'schedule_as_geometry/schedule'
require_relative 'schedule_as_geometry/schedules'
require_relative 'schedule_as_geometry/active_record_types'
require_relative 'schedule_as_geometry/act_as_linestring_schedule'

module ScheduleAsGeometry
  class Error < StandardError; end
end
