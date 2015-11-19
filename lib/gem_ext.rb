require 'engtagger'

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
