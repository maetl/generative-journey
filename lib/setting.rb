class Setting
  attr_reader :name, :lexicon, :geography

  def initialize(name)
    @name = name
    @lexicon = Lexicon.new(name)
    @geography = Geography.new(name)
  end
end
