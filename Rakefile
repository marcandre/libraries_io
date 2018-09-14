require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

module CallSequence
  def call_sequence
    params = param_set.to_code
    if params.empty?
      symbol.to_s
    else
      "#{symbol}(#{params})"
    end
  end
end

def gen_doc(namespace, prefix = '')
  namespace.endpoints.each do |_key, endpoint|
    puts "* [#{prefix}.#{endpoint.call_sequence}](#{endpoint.docs_link})"
  end
  namespace.namespaces.each do |_key, sub|
    gen_doc(sub, "#{prefix}.#{sub.call_sequence}")
  end
end

task :gen_doc do
  require_relative 'lib/libraries_io'

  TLAW::APIPath.extend CallSequence

  gen_doc(LibrariesIO::API, 'api')
end
