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

    def scheduled_in_this_day?
      if schedule.last_day?
        return time.day == time.end_of_month.day
      elsif schedule.latest_weekday
        return time.day == calc_latest_weekday
      elsif schedule.ordered_weekday
        return time.day == calc_ordered_weekday
      end

      super
    end

    def calc_latest_weekday
      target = time.change(day: schedule.latest_weekday)
      case target.wday
      when 0 # SUN
        target.day + 1
      when 6 # SAT
        target.day - 1
      else
        target.day
      end
    end

    def calc_ordered_weekday
      wday, order = schedule.ordered_weekday

      month = time.month
      curr = time.beginning_of_month
      while curr.wday != wday
        curr = curr.advance(days: 1)
      end

      if curr.month != month
        curr = curr.advance(weeks: 1)
      end

      (order - 1).times do
        curr = curr.advance(weeks: 1)
      end

      if curr.month != month
        raise ArgumentError, "invalid cron string '#{@source}'"
      end

      curr.day
    end

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
