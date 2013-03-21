class TimeBean
  attr_reader :startTime,:endTime,:totalTime
  def initialize(startTime,endTime,totalTime)
    @startTime=startTime;
    @endTime=endTime;
    @totalTime=totalTime;
  end
end