module Push
  class Source
    class << self
      def refresh_rate(data_method)
        rates = {
          :push => 500.years, # Never refresh a push-based widget
        }

        rates[data_method.to_sym]
      end

      def retention_length(data_method)
        lengths = {
          :pull => 2, # Only keep the last two pushes
        }

        lengths[data_method.to_sym]
      end

      def push(url) # no-op
      end
    end
  end
end
