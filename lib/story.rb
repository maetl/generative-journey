class Story
  attr_reader :setting, :title

  def initialize(rng)
    @rng = rng
    @setting = nil
    @title = nil
  end

  def generate
    generate_setting
    generate_title
    self
  end

  private

  def generate_title
    @title = Title.generate(@setting.region, @rng)
  end

  def generate_setting
    @setting = Setting.generate(@rng)
  end

  def generate_transport
    [:car, :ship, :train, :motorbike, :foot].sample(random: @rng)
  end

  def generate_narrative
    [:road_trip, :walking_the_earth, :golden_fleece].sample(random: @rng)
  end
end
