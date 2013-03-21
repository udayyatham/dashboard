class TestSuitesInfoForLinks
  attr_reader :suiteExecutedId,:startTime,:endTime
  def initialize(suiteExecutedId,startTime,endTime)
    @suiteExecutedId=suiteExecutedId;
    @startTime=startTime;
    @endTime=endTime;
  end
end