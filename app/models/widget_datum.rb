class WidgetDatum < ActiveRecord::Base
  belongs_to :widget
  serialize :value
end
