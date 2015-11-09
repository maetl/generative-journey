Dir["lib/*.rb"].each { |path| require_relative(path) }

task :generate do
  story = Story.new(Random.new)
  story.generate

  puts story.title
  puts "Region: #{story.setting.region}"
  puts "Plot: #{story.plot.type}"
end
