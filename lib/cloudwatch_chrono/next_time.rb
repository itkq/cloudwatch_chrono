require "chrono/next_time"

module CloudwatchChrono
  class NextTime < Chrono::NextTime
    def to_time
      # the longest cycle is 4 years (leap year)
      # Note that the combination of day-month and wday is OR
      max_time = time + (365 * 3 + 366).days
      while @time < max_time
        case
        when !scheduled_in_this_year?
          carry_year
        when !scheduled_in_this_month?
          carry_month
        when !scheduled_in_this_day?
          carry_day
        when !scheduled_in_this_hour?
          carry_hour
        when !scheduled_in_this_minute?
          carry_minute
        else
          return @time
        end
      end
      raise ArgumentError, "invalid cron string '#{@source}'"
    end

    private

    def schedule
      @schedule ||= Schedule.new(source)
    end

    def scheduled_in_this_year?
      schedule.years.include?(time.year)
    end

    def carry_year
      self.time = time.next_year.beginning_of_year
    end
  end
end
