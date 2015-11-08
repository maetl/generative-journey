class Setting
  attr_reader :region

  def self.generate(rng)
    region = [:africa, :amazon, :pacific, :arctic, :america, :australia].sample(random: rng)
    self.new(region)
  end

  def initialize(region)
    @region = region
  end
end
