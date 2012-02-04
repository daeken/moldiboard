class Widget < ActiveRecord::Base
  belongs_to :dashboard
  has_many :widget_data

  def render
    source.send(data_method, data_param)
  end

  def source
    "#{data_source.capitalize}::Source".constantize
  end
end
