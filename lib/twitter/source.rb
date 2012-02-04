module Twitter
  class Source
    class << self
      def allowed_methods
        [:search,
         :mentions,
         :user_info,
         :follower_count]
      end

      def allowed_method?(method)
        allowed_methods.include?(method.to_sym)
      end

      def refresh_rate(data_method)
        rates = {
          :search         => 5.minutes,
          :mentions       => 5.minutes,
          :user_info      => 5.minutes,
          :follower_count => 5.minutes,
        }

        rates[data_method.to_sym]
      end

      def retention_length(data_method)
        lengths = {
          :search         => 1,
          :mentions       => 1,
          :user_info      => 1,
          :follower_count => 50
        }

        lengths[data_method.to_sym]
      end

      def search(needle)
        json_request("http://search.twitter.com/search.json?q=#{needle}")["results"]
      end

      def mentions(screen_name)
        search(screen_name)
      end

      def user_info(screen_name)
        json_request("https://api.twitter.com/1/users/show.json?screen_name=#{screen_name}")
      end

      def follower_count(screen_name)
        user_info(screen_name)["followers_count"]
      end

      def json_request(url)
        JSON(RestClient.get(url))
      end
    end
  end
end
