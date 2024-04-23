# frozen_string_literal: true

module ScheduleAsGeometry
  module LineString
    class Schedule < ::ActiveRecord::Type::Json
      def type
        :schedule_linestring
      end

      def deserialize(value)
        ScheduleAsGeometry::Schedule.parse(value)
      end

      def serialize(value)
        value
      end
    end

    class Schedules < ::ActiveRecord::Type::Json
      def type
        :schedule_multi_linestring
      end

      def deserialize(value)
        ScheduleAsGeometry::Schedules.parse(value)
      end

      def serialize(value)
        value
      end
    end
  end
end
