# frozen_string_literal: true

module ScheduleAsGeometry
  class Schedule
    include ActiveModel::Model

    attr_reader :start_at, :end_at, :start_datetime, :end_datetime, :raw, :error

    def initialize(attributes = {})
      @raw = attributes[:raw]
      @end_at = attributes[:end_at]
      @start_at = attributes[:start_at]

      @end_datetime = Time.zone.at(@end_at)
      @start_datetime = Time.zone.at(@start_at)
    end

    class << self
      def parse(attributes)
        raw = attributes
        coordinates, create_raw = extract_coordinates(attributes)

        if create_raw
          line_string = ScheduleAsGeometry::Geometry.from_coordinates(coordinates)
          raw = line_string.as_binary
        end

        new(
          raw:,
          end_at: coordinates[1][0].to_i,
          start_at: coordinates[0][0].to_i
        )
      rescue StandardError => e
        @error = e.message

        nil
      end

      private

      def extract_coordinates(attributes)
        return [attributes[:coordinates].presence || attributes['coordinates'] || [], true] if attributes.is_a?(Hash) && (attributes.key?(:coordinates) || attributes.key?('coordinates'))
        return [[], false] unless attributes.is_a?(String)

        if attributes.encoding.to_s == 'ASCII-8BIT'
          linestring = ScheduleAsGeometry::Geometry.parse_bin(attributes)

          [linestring.coordinates, false]
        else
          parsed_json = ActiveSupport::JSON.decode(attributes)

          [parsed_json['coordinates'] || [], true]
        end
      end
    end

    def type
      :linestring
    end

    def ==(other)
      start_at == other.start_at && end_at == other.end_at
    end

    def to_json(*_args)
      JSON.generate(
        {
          start_at:,
          end_at:
        }
      )
    end

    def to_sql
      "LineString(#{to_coordinates_sql})"
    end

    private

    def to_coordinates_sql
      "#{start_at} 0,#{end_at} 0"
    end
  end
end
