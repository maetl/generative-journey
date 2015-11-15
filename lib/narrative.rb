class Narrative
  def self.generate(setting, rng)
    narrative_options = case setting.region
    when :america
      [:road_trip]
    when :pacific
      [:shipwreck]
    else
      [:walking_the_earth, :seekers_quest]
    end

    self.new(narrative_options.sample(random: rng))
  end

  def initialize()

  end
end
