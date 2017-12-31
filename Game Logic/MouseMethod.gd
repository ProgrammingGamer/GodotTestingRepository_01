extends CanvasItem

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var clickx #= Vector2()
var clicky #= Vector2()
var tilextype = 0
var tileytype = 0
var eqy = 15
var eqx = 27

func _ready():
	
	set_fixed_process(true)
	pass

func _fixed_process(delta): #_ready():
	
	clickx = get_local_mouse_pos().x
	clicky = get_local_mouse_pos().y
	
	#tile is (0,-1)
	
	#y<(13/7)x
	#y>(13/7)x-14
	#y>(-13/7)x
	#y<(-13/7)x+14
	#y<(13/7)x+14(z)
	#y>(13/7)x+14(w)
	
#	tilextype = clicky<clickx[13/7]
	
	if(clickx > 1*eqx):
		tilextype = 1
		pass
	else:
		tilextype = 0
		pass
	if(clicky > 1*eqy):
		tileytype = 1
		pass
	else:
		tileytype = 0
		pass
	
	print(clickx, ", ", clicky, ": Tile: ", tilextype, ", ", tileytype)
	
	pass
