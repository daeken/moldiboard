paper = null

do_every = (delay, cb) ->
	setInterval cb, delay * 1000

initializers = 
	text: (def) -> 
		
	numeric: (def) ->
		

initialize = (def) -> initializers[def.data_type] def

renderers = 
	text: (def, data) ->
		
	numeric: (def, data) -> 
		console.log def.name + ': ' + data.widget_data[0].value

render = (def, data) -> renderers[def.data_type] def, data

widget = (def) ->
	initialize def
	
	do_every 30, update = () ->
		success = (data) ->
			render def, data
			
		error = () ->
			console.log 'fail' # XXX: This should throw a caution sign on the widget
		
		$.ajax def.url, {dataType: 'json', success: success, error: error}
	update()
		

window.dashboard_init = (dashboard) ->
	document.title = dashboard.name + ' \u2014 Moldiboard'
	de = document.documentElement

	paper = Raphael 0, 0, de.clientWidth, de.clientHeight
	window.onresize = () ->
		paper.setSize de.clientWidth, de.clientHeight
	
	dashboard.widgets.map widget
