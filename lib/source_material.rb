require 'engtagger'
require 'octokit'
require 'json'

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
  module Gutenberg
    class Library
      def initialize
        @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
      end

      def download_books(bookids)
        bookids.each do |bookid|
          id_fragment = "_#{bookid}"
          query = "#{id_fragment} user:GITenberg"

          @client.search_repos(query).items.each do |repo|
            if repo.name.end_with?(id_fragment)
              download_text(repo, bookid)
              download_meta(repo, bookid)
            end
          end
        end
      end

      def download_text(repo, bookid)
        text = read_file(repo.full_name, "#{bookid}.txt")
        write_file("source/#{bookid}.txt", text)
      end

      def download_meta(repo, bookid)
        begin
          meta = read_file(repo.full_name, 'metadata.json')
        rescue Octokit::NotFound => e
          meta = JSON.pretty_generate(name: repo.name, description: repo.description)
        end
        write_file("meta/#{bookid}.json", meta)
      end

      def read_file(repo_name, path)
        @client.contents(repo_name, path: path, accept: 'application/vnd.github.v3.raw')
      end

      def write_file(filepath, content)
        File.open("data/gutenberg/#{filepath}", 'w') do |file|
          file.puts(content)
        end
      end
    end
  end

  class Lexicon
    attr_accessor :adverbs, :adjectives, :comparatives, :superlatives

    def initialize(name, corpus)
      @name = name
      @corpus = corpus
      @adjectives = {}
      @adverbs = {}
      @comparatives = {}
      @superlatives = {}
    end

    def compile
      @corpus.each do |document|
        compile_word_list(:adverbs, document)
        compile_word_list(:adjectives, document)
      end

      save_word_list(:adverbs)
      save_word_list(:adjectives)
    end

    def compile_word_list(part_of_speech, document)
      word_list = send(part_of_speech)

      word_list.merge!(document.send(part_of_speech))

      word_list.reject! do |k,v|
        k.chr.is_upper? or v <= 3
      end
    end

    def save_word_list(part_of_speech)
      File.open("data/lexicon/#{@name.to_s}/#{part_of_speech.to_s}.txt", 'w+') do |file|
        send(part_of_speech).keys.each do |word|
          file.puts(word)
        end
      end
    end
  end

  class Corpus
    def initialize(path=Dir.pwd, &builder)
      @path = path
      @collection = []
      builder.call(@collection) if block_given?
    end

    def each
      return enum_for(:each) unless block_given?

      @collection.each do |bookid|
        yield Document.new(File.read("#{@path}/#{bookid}.txt"))
      end
    end
  end

  class Document
    def initialize(text)
      @tagger = EngTagger.new
      @tagged = @tagger.add_tags(text)
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
