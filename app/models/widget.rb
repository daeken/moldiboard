class Widget < ActiveRecord::Base
  belongs_to :dashboard
  has_many :widget_data

  validates_uniqueness_of :name, :scope => :dashboard_id

  before_validation Proc.new { |widget| widget.refreshed_at ||= 1.year.ago }
  before_validation Proc.new { |widget| widget.source.allowed_method?(widget.data_method) } # Is this an allowed method for the given source?

  attr_accessible :name, :data_source, :data_method, :data_param, :dashboard

  def to_param
    name
  end

  def protected?
    dashboard.protected?
  end

  def cleanup!
    keep = source.retention_length(data_method)
    destroyable = widget_data.all[keep..-1]
    destroyable.collect(&:destroy) if destroyable
  end

  def refresh_source!
    datum = widget_data.create(:value => source.send(data_method, data_param))
    self.refreshed_at = Time.now
    save
  end

  def refresh_source
    refresh_source! if data_stale?
  end

  def data_stale?
    refreshed_at < refresh_rate.ago
  end

  def refresh_rate
    source.refresh_rate(data_method)
  end

  def render
    widget_data
  end

  def source
    "#{data_source.capitalize}::Source".constantize
  end
end
