class CountInfoBean
  attr_reader :passedCount,:failedCount,:skippedCount,:totalCount,:executed
  def initialize(passedCount,failedCount,skippedCount,totalCount,executed)
    @passedCount=passedCount;
    @failedCount=failedCount;
    @skippedCount=skippedCount;
    @executed=executed;
    @totalCount=totalCount;
  end
end