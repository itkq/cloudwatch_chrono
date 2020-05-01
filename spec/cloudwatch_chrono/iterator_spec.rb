require "spec_helper"

describe CloudwatchChrono::Iterator do
  describe "#next" do
    # 2020-01-01: Wed
    [
      '2020-01-01 00:00:00', '2020-01-01 10:00:00', '0 10 * * ? *',
      '2020-01-01 00:00:00', '2022-01-01 10:00:00', '0 10 * * ? 2022',
      '2020-01-01 09:00:00', '2020-02-01 08:00:00', '0 8 1 * ? *',
    ].each_slice(3) do |from, to, source|
      it "ticks from #{from} to #{to} by #{source}" do
        now = Time.parse(from)
        expect(described_class.new(source, now: now).next).to eq(Time.parse(to))
      end
    end
  end
end
