module TLAW
  class << DSL::BaseBuilder
    def globals
      @@globals ||= []
    end
  end

  class DSL::NamespaceBuilder
    def global(name, type = nil, **opts)
      self.class.globals << [name, type, opts]
    end

    module GlobalAwareEndpoint
      def endpoint(*args, &block)
        super(*args) do
          instance_eval(&block)
          self.class.globals.each do |name, type, opts|
            param(name, type, **opts)
          end
        end
      end
    end
    prepend GlobalAwareEndpoint
  end
end
