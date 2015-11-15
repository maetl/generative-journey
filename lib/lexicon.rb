require 'pathname'

class Lexicon
  attr_reader :adverbs, :adjectives, :comparatives, :superlatives

  def initialize(name)
    @adjectives = read_word_list(name, :adjectives)
    @adverbs = read_word_list(name, :adverbs)
    @comparatives = read_word_list(name, :comparatives)
    @superlatives = read_word_list(name, :superlatives)
  end

  def read_word_list(name, pos_name)
    File.read("data/lexicon/#{name}/#{pos_name}.txt").lines.map(&:strip)
  end
end
