class << LibrariesIO::API
  private def endpoint_doc(namespace, name)
    id = if name == :info
      namespace
    else
      [namespace, name.to_s.gsub('_', '-')].compact.join('-')
    end
    [docs_link, id].join('#')
  end

  def setup_all_doc(prefix = nil, base = self)
    traverse(:endpoints) do |endpoint|
      endpoint.docs_link = endpoint_doc(endpoint.parent.symbol, endpoint.symbol)
    end
  end
end
