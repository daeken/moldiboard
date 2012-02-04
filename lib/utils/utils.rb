module Moldiboard
  class Utils
    class << self
      def create_default_install!
        dashboard = Dashboard.create(:name => "default", :protected => false)

        widget = Widget.create(:dashboard   => dashboard,
                               :name        => "Recent Bushido Tweets",
                               :data_source => "twitter",
                               :data_method => "search",
                               :data_param  => "bushi.do")

        widget = Widget.create(:dashboard   => dashboard,
                               :name        => "Daeken's Follower Count",
                               :data_source => "twitter",
                               :data_method => "follower_count",
                               :data_param  => "daeken")

        dashboard.refresh!
      end 
    end
  end
end
