module Pull
  class Source
    class << self
      def refresh_rate(data_method)
        rates = {
          :pull => 5.minutes,
        }

        rates[data_method.to_sym]
      end

      def retention_length(data_method)
        lengths = {
          :pull           => 10,
        }

        lengths[data_method.to_sym]
      end

      def pull(url)
        json_request(url)
      end

      def json_request(url)
        JSON(RestClient.get(url))
      end
    end
  end
end
