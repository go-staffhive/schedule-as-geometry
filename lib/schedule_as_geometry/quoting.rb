# frozen_string_literal: true

module ScheduleAsGeometry
  module ActiveRecord
    module ConnectionAdapters
      module MySQL
        module QuotingOverride
          def quote(value)
            case value
            when ::ScheduleAsGeometry::Schedule, ::ScheduleAsGeometry::Schedules then quote_geom(value)
            when String, Symbol, ActiveSupport::Multibyte::Chars
              "'#{quote_string(value.to_s)}'"
            when true       then quoted_true
            when false      then quoted_false
            when nil        then 'NULL'
            when BigDecimal then value.to_s('F')
            when Numeric, ActiveSupport::Duration then value.to_s
            when ::ActiveRecord::Type::Binary::Data then quoted_binary(value)
            when ::ActiveRecord::Type::Time::Value then "'#{quoted_time(value)}'"
            when Date, Time then "'#{quoted_date(value)}'"
            when Class      then "'#{value}'"
            else raise TypeError, "can't quote #{value.class.name}"
            end
          end

          private

          def quote_geom(value)
            "ST_GeomFromText('#{value.to_sql}')"
          end
        end
      end
    end
  end
end
