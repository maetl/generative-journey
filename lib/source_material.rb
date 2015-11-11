require 'engtagger'

class String
  def is_upper?
    not self.match /[[:lower:]]/
  end

  def is_lower?
    not self.match /[[:upper:]]/
  end
end

class EngTagger
  RB = get_ext('rb')

  def get_adverbs(tagged)
    return nil unless valid_text(tagged)
    RB
    trimmed = tagged.scan(RB).map do |n|
      strip_tags(n)
    end
    ret = Hash.new(0)
    trimmed.each do |n|
      n = stem(n)
      next unless n.length < 100  # sanity check on word length
      ret[n] += 1 unless n =~ /\A\s*\z/
    end
    return ret
  end
end

module SourceMaterial
  class Document
    def initialize(file)
      @tagger = EngTagger.new
      @tagged = @tagger.add_tags(File.read(file))
    end

    def adjectives
      @tagger.get_adjectives(@tagged)
    end

    def comparatives
      @tagger.get_comparative_adjectives(@tagged)
    end

    def superlatives
      @tagger.get_superlative_adjectives(@tagged)
    end

    def adverbs
      @tagger.get_adverbs(@tagged)
    end
  end
end
