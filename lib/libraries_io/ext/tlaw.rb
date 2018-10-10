module TLAW
  class DSL::NamespaceWrapper
    def self.globals
      @@globals ||= []
    end

    def global(name, type = nil, **opts)
      DSL::NamespaceWrapper.globals << [name, type, opts]
    end

    module GlobalAwareEndpoint
      def endpoint(*args, &block)
        super(*args) do
          instance_eval(&block)
          DSL::NamespaceWrapper.globals.each do |name, type, opts|
            param(name, type, **opts)
          end
        end
      end
    end
    prepend GlobalAwareEndpoint
  end
end
