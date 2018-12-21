module TLAW
  class DSL::BaseBuilder
    def symbol
      params[:symbol]
    end unless method_defined? :symbol

    def self.after_each_blocks
      @@after_each_blocks ||= []
    end
  end

  class DSL::NamespaceBuilder
    def after_each(what = :all, &block)
      raise NotImplemented unless what == :endpoint
      self.class.after_each_blocks << block
    end

    module AfterEachAwareEndpoint
      def endpoint(*args, &block)
        super(*args) do
          instance_eval(&block)
          self.class.after_each_blocks.each do |block|
            instance_eval(&block)
          end
        end
      end
    end
    prepend AfterEachAwareEndpoint
  end
end
