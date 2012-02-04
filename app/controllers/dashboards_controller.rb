class DashboardsController < ApplicationController
  def index
    @dashboards = Dashboard.order("name").all
  end

  def show
    @dashboard = Dashboard.find_by_name(params[:id])
  end
end
