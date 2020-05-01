require "chrono/iterator"

module CloudwatchChrono
  class Iterator < Chrono::Iterator
    def next
      self.now = NextTime.new(now: now, source: source).to_time
    end
  end
end
