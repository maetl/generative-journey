class Title
  # Crap title generator as a placeholder
  def self.generate(region, rng)
    title = case region
    when :africa
      'African Adventure'
    when :pacific
      'South Sea Adventure'
    when :arctic
      'Journey to the Arctic'
    when :australia
      'Australian Adventure'
    when :america
      'Journey Across America'
    else
      'A Generative Journey'
    end

    self.new(title)
  end

  def initialize(title)
    @title = title
  end

  def to_s
    @title
  end
end
