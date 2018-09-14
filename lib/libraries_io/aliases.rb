class LibrariesIO::API < TLAW::API
  PLATFORMS = %i[go npm packagist maven rubygems pypi nuget bower wordpress cocoapods cpan cargo clojars
                 cran meteor hackage atom hex puppet platformio homebrew emacs swiftpm pub carthage julia
                 sublime dub elm racket haxelib nimble alcatraz purescript inqlude]

  # define aliases so that `api.rubygems` == `api.platform('rubygems')`
  PLATFORMS.each do |name|
    define_method name do
      platform(name.to_s)
    end
  end
end
