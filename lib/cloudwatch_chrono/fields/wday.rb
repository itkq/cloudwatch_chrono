require "chrono/fields/wday"

module CloudwatchChrono
  module Fields
    class Wday < Chrono::Fields::Wday
      CLOUDWATCH_REGEXP = %r<\A(?:(?<step>(?:\*|\?|(?:(?<atom>\d+|sun|mon|tue|wed|thu|fri|sat)(?:-\g<atom>)?))(?:/\d+)?)(?:,\g<step>)*)\z>ix.freeze

      def initialize(source)
        if source == 'L'
          @last_wday = true
        else
          unless CLOUDWATCH_REGEXP =~ source
            raise InvalidField.new('Unparsable field', source)
          end
        end
        @source = source
      end

      def interpolated
        if @last_wday
          '6-6'
        else
          super.gsub("?", "#{range.first}-#{range.last}")
        end
      end
    end
  end
end
