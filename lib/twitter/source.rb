module Twitter
  class Source
    class << self
      def search(needle)
        JSON(RestClient.get("http://search.twitter.com/search.json?q=#{needle}"))["results"]
      end

      def mentions(screen_name)
        search(screen_name)
      end

      def user_info(screen_name)
        JSON(RestClient.get("https://api.twitter.com/1/users/show.json?screen_name=#{screen_name}"))
      end

      def follower_count(screen_name)
        user_info(screen_name)["followers_count"]
      end
    end
  end
end
