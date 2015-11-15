Dir["lib/*.rb"].each { |path| require_relative(path) }

namespace :clean do
  task :gutenberg do
    Dir['data/gutenberg/source/**.txt'].each do |filepath|
      sh "./script/guten-gutter --output-dir data/gutenberg/clean #{filepath}"
    end
  end
end

namespace :download do
  task :gutenberg do
    library = SourceMaterial::Gutenberg::Library.new
    library.download_books(File.read('data/gutenberg/books.txt').split("\n"))
  end
end

namespace :install do
  task :lexicon do
    SourceMaterial::Lexicon.compile(:voyage)
  end
end

namespace :generate do
  task :story do
    story = Story.new(Random.new)
    story.generate

    puts story.title
    puts "Region: #{story.setting.region}"
    puts "Plot: #{story.plot.type}"
  end
end
