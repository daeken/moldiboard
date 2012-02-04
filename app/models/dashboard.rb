class Dashboard < ActiveRecord::Base
  has_many :widgets

  before_validation Proc.new { |dashboard| dashboard.protected ||= true }

  attr_accessible :name, :protected

  def to_param
    name
  end

  def cleanup!
    widgets.collect(&:cleanup!)
  end

  def refresh!
    widgets.collect(&:refresh_source)
  end
end
