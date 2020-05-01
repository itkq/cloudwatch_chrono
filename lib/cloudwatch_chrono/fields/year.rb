module CloudwatchChrono
  module Fields
    class Year < Chrono::Fields::Base
      private

      def range
        1970..2199
      end
    end
  end
end
