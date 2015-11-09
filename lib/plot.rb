class Plot
  def self.generate(setting, rng)
    plot_types = case setting.region
    when :america
      [:road_trip]
    when :pacific
      [:shipwreck]
    else
      [:walking_the_earth, :seekers_quest]
    end

    self.new(plot_types.sample(random: rng))
  end

  attr_accessor :type

  def initialize(type)
    @type = type
  end
end
