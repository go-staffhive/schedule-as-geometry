# frozen_string_literal: true

module ScheduleAsGeometry
  module ActAsLinestringSchedule
    extend ActiveSupport::Concern

    module ClassMethods
      def schedule_linestring(*columns)
        columns.each do |col|
          attribute(col, ScheduleAsGeometry::LineString::Schedule.new)
        end
      end

      def schedule_multi_linestring(*columns)
        columns.each do |col|
          attribute(col, ScheduleAsGeometry::LineString::Schedules.new)
        end
      end
    end
  end
end
