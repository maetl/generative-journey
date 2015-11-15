class Story
  attr_reader :setting, :plot, :title

  def initialize(rng)
    @rng = rng
    @setting = nil
    @title = nil
  end

  def generate
    generate_setting
    generate_plot
    generate_title
    self
  end

  private

  def generate_title
    @title = Title.generate(@setting.region, @rng)
  end

  def generate_setting
    @setting = Setting.new(:voyage)
    #@setting = Setting.generate(@rng)
  end

  def generate_plot
    @plot = Plot.generate(@setting, @rng)
  end
end
