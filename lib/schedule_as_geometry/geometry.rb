# frozen_string_literal: true

module ScheduleAsGeometry
  class Geometry
    class << self
      def parse_bin(bin)
        parser.parse(bin[4..])
      end

      def from_coordinates(coordinates, type: :linestring)
        if type == :linestring
          line_string_from_coords(coordinates)
        else
          multi_line_string_from_coords(coordinates)
        end
      end

      private

      def line_string_from_coords(coordinates)
        points = coordinates.map do |x, y|
          cartesian_factory.point(x, y)
        end

        cartesian_factory.line_string(points)
      end

      def multi_line_string_from_coords(coordinates)
        line_strings = coordinates.map do |coordinate|
          line_string_from_coords(coordinate)
        end

        cartesian_factory.multi_line_string(line_strings)
      end

      def parser
        @parser ||= RGeo::WKRep::WKBParser.new
      end

      def cartesian_factory
        @cartesian_factory ||= RGeo::Cartesian::Factory.new
      end
    end
  end
end
