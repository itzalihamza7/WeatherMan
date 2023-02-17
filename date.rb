class Date
  attr :year, :month, :day

  def initialize(year, month, day)
    @year = year
    @month = month
    @day = day
  end

  def ==(other)
    @year == other.year
    @month == other.month
    @day == other.day
  end
end
