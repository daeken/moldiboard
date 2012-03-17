class WidgetsController < ApplicationController
  def show
    @dashboard = Dashboard.find_by_name(params[:dashboard_id])
    @widget = @dashboard.widgets.find_by_name(params[:id])

    #authenticate_user! if @widget.protected?

    render :json => @widget.to_json(:include => :widget_data)
  end
end
