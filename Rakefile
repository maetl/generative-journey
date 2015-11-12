Dir["lib/*.rb"].each { |path| require_relative(path) }

task :generate do
  story = Story.new(Random.new)
  story.generate

  puts story.title
  puts "Region: #{story.setting.region}"
  puts "Plot: #{story.plot.type}"
end

namespace :install do
  task :lexicon do
    adjectives = {}
    adverbs = {}
    comparatives = {}
    superlatives = {}

    # Source lexicon for sea voyages
    ['21085.txt'].each do |book_file|
      source = SourceMaterial::Document.new("./data/gutenberg/clean/#{book_file}")
      adjectives.merge!(source.adjectives)
      adverbs.merge!(source.adverbs)
      comparatives.merge!(source.comparatives)
      superlatives.merge!(source.superlatives)
    end

    adjectives.reject! do |k,v|
      k.chr.is_upper? or v <= 3
    end

    adverbs.reject! do |k,v|
      k.chr.is_upper? or v <= 3
    end

    comparatives.reject! do |k,v|
      k.chr.is_upper? or v <= 3
    end

    superlatives.reject! do |k,v|
      k.chr.is_upper? or v <= 3
    end

    File.open('./data/lexicon/voyage/adjectives.txt', 'w+') do |file|
      adjectives.keys.each do |word|
        file.puts(word)
      end
    end

    File.open('./data/lexicon/voyage/adverbs.txt', 'w+') do |file|
      adverbs.keys.each do |word|
        file.puts(word)
      end
    end

    File.open('./data/lexicon/voyage/comparatives.txt', 'w+') do |file|
      comparatives.keys.each do |word|
        file.puts(word)
      end
    end

    File.open('./data/lexicon/voyage/superlatives.txt', 'w+') do |file|
      superlatives.keys.each do |word|
        file.puts(word)
      end
    end
  end
end
