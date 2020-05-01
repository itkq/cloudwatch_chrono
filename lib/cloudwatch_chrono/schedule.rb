require "chrono/schedule"

module CloudwatchChrono
  class Schedule < Chrono::Schedule
    def initialize(source)
      if %r<\A[ \t]*(?:(?<field>\S+)[ \t]+){5}\g<field>[ \t]*\z> !~ source
        raise Chrono::Fields::Base::InvalidField.new('invalid source', source)
      end
      @source = source
    end

    def wdays
      Fields::Wday.new(fields[4]).to_a
    end

    def years
      Fields::Year.new(fields[5]).to_a
    end

    def days?
      !%w[* ?].include?(fields[2])
    end

    def wdays?
      !%w[* ?].include?(fields[4])
    end

    def last_day?
      fields[2] == 'L'
    end

    def latest_weekday
      fields[2].slice(/\A(\d+)W\z/, 1)
    end

    # e.g. 3#2 means the second Tuesday and returns [3, 2]
    def ordered_weekday
      m = fields[2].match(/\A([0-6])#([1-5])\z/)
      if m
        m[1, 2].map(&:to_i)
      end
    end
  end
end
