class << LibrariesIO::API
  private def endpoint_doc(namespace, name)
    id = if name == :info
      namespace
    else
      [namespace, name.to_s.gsub('_', '-')].compact.join('-')
    end
    [LibrariesIO::API.docs_link, id].join('#')
  end

  def setup_all_doc(prefix = nil, base = self)
    base.endpoints.values.each do |endpoint|
      endpoint.docs_link ||= endpoint_doc(prefix, endpoint.symbol)
    end
    base.namespaces.values.each do |namespace|
      setup_all_doc(namespace.symbol, namespace)
    end
  end
end
