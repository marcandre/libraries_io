require 'tlaw'

require_relative 'libraries_io/version'
require_relative 'libraries_io/api'
require_relative 'libraries_io/aliases'
require_relative 'libraries_io/doc'

module LibrariesIO
  class << self
    attr_accessor :api_key

    def new(**options)
      API.new(**options)
    end

    def api_key
      @api_key ||= ENV['LIBRARIES_IO_API_KEY'] ||  File.read('.libraries_io_api_key').chomp
    rescue
      raise [
        'You must specify a Libraries.io API key.',
        'Get it at https://libraries.io/account and',
        'specify it with an of:',
        '  LibrariesIO.new(api_key: "your_key")',
        '  or calling `LibrariesIO.api_key = "your_key"`',
        '  or setting the environment variable LIBRARIES_IO_API_KEY',
        '  or writing it to a file ".libraries_io_api_key".',
      ].join("\n")
    end

    API.setup_all_doc
  end
end
