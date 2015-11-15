class Region
  def self.generate(region_name)
    geographic_region = Module.const_get(Inflecto.camelize(region_name))
    geographic_region.new
  end

  class GeographicRegion
    def self.genres(*args)
      @genres = args
    end

    def genre
      @genre || generate_genre
    end
  end

  class Africa < GeographicRegion
  end

  class Amazon < GeographicRegion
  end

  class Pacific < GeographicRegion
  end

  class Arctic < GeographicRegion
  end

  class America < GeographicRegion
  end

  class Australia < GeographicRegion
  end

  class Asia < GeographicRegion
  end
end
