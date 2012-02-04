class WidgetDatum < ActiveRecord::Base
  belongs_to :widget
  serialize :value

  default_scope :order => :created_at

  attr_accessible :value
end
