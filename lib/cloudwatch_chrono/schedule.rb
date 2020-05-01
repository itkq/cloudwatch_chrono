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
  end
end
