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

    # Source lexicon for sea voyages
    ['21085.txt'].each do |book_file|
      source = SourceMaterial::Document.new("./data/gutenberg/clean/#{book_file}")
      adjectives.merge!(source.adjectives)
    end

    adjectives.reject! do |k,v|
      k.chr.is_upper? or v <= 3
    end

    File.open('./data/lexicon/voyage/adjectives.txt', 'w+') do |file|
      adjectives.keys.each do |word|
        file.puts(word)
      end
    end
  end
end
