de = null

print = console.log.bind console

do_every = (delay, cb) ->
	setInterval cb, delay * 1000

class Numeric
	constructor: (@def) ->
		for name of @def
			@[name] = @def[name]
		@initialize()
		@update()
		do_every 30, @update
	
	initialize: ->
		@titleWidget.text @name
		@container.css('width', '250px').css('height', '250px')
		@container.append(@valueWidget = $('<div class="numeric-main" style="width: 250px; height: 226px;"></div>'))

	update: =>
		success = (data) =>
			@render data
			
		error = () ->
			print 'fail' # XXX: This should throw a caution sign on the widget
		
		$.ajax @url, {dataType: 'json', success: success, error: error}
	
	render: (data) ->
		@valueWidget.text data.widget_data[0].value

class Text
	constructor: (@def) ->
		for name of @def
			@[name] = @def[name]
		@initialize()
		@update()
		do_every 30, @update
	
	initialize: ->
		@titleWidget.text @name
		@container.css('left', '400px')
		@container.css('width', '500px').css('height', '250px')
		@container.append(@valueWidget = $('<div class="text-main" style="width: 500px; height: 226px;"></div>'))
		@carousel = []
		@carouselCurrent = 0
		@rendering = false

	update: =>
		success = (data) =>
			@carousel = data.widget_data[0].value
			@render data if !@rendering
			
		error = () ->
			print 'fail' # XXX: This should throw a caution sign on the widget
		
		$.ajax @url, {dataType: 'json', success: success, error: error}
	
	render: (data) =>
		if @carousel.length > 0
			@carouselCurrent = 0 if @carouselCurrent >= @carousel.length
			@valueWidget.text @carousel[@carouselCurrent].text
			@carouselCurrent = (@carouselCurrent + 1) % @carousel.length
		do_every 10, @render

build_widget = (def) ->
	def.container = $('<div id="widget_' + def.id + '" class="widget">')
	def.container.append(def.titleWidget = $('<div class="widget-title"></div>'))
	$('body').append def.container
	switch def.data_type
		when 'numeric' then new Numeric def
		when 'text' then new Text def

window.dashboard_init = (dashboard) ->
	document.title = dashboard.name + ' \u2014 Moldiboard'
	de = document.documentElement

	dashboard.widgets.map build_widget
