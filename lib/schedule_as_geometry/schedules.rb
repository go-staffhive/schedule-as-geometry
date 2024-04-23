# frozen_string_literal: true

module ScheduleAsGeometry
  class Schedules
    include ActiveModel::Model

    attr_accessor :items, :raw, :error

    def initialize(attributes = {})
      @raw = attributes[:raw]
      @items = attributes[:items]
    end

    class << self
      def parse(attributes)
        raw = attributes
        coordinates, create_raw = extract_coordinates(attributes)

        if create_raw
          multi_line_string = ScheduleAsGeometry::Geometry.from_coordinates(coordinates, :multi_linestring)
          raw = multi_line_string.as_binary
        end

        new(
          raw:,
          items: coordinates.map do |coordinate|
            ScheduleAsGeometry::Schedule.parse(coordinates: coordinate)
          end
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

    def to_json(*_args)
      JSON.generate(items.map(&:to_json))
    end

    def to_sql
      "MultiLineString(#{to_coordinates_sql})"
    end

    private

    def to_coordinates_sql
      items.map { |utr| "(#{utr.to_coordinates_sql})" }.join(',')
    end
  end
end
