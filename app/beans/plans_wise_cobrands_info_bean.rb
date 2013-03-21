class PlansWiseCobrandsInfoBean
  attr_reader :cobrandInfoBeanHash,:environment,
  :release,:suiteName
  def initialize(cobrandInfoBeanHash,environment,release,suiteName)
    @cobrandInfoBeanHash=cobrandInfoBeanHash;
    @environment=environment;
    @release=release;
    @suiteName=suiteName;
  end
end