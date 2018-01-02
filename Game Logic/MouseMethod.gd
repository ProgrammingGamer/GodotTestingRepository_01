extends CanvasItem

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var Precoor = get_node("Pre-coordinates")
onready var Postcoor = get_node("Post-coordinates")

var clickx #= Vector2()
var clicky #= Vector2()
var tilextype = 0
var tileytype = 0
var eqy = 15
var eqx = 27
var debugtools = 0

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
	
	
	#map.set_cell(tile.x, tile.y, 20)
	
	
#	if(clickx > 1*eqx):
#		tilextype = 1
#		#set_cell(1, 1, 2)
#		pass
#	else:
#		tilextype = 0
#		pass
#	if(clicky > 1*eqy):
#		tileytype = 1
#		pass
#	else:
#		tileytype = 0
#		pass
	
	
#	tilextype = clickx/26
#	tileytype = ((clicky/14) - 1.5)
	
	tilextype = (clicky/14) + (clickx / 26)
	tileytype = -((clickx / 26) - (clicky/14)) - 1
	
	if (tileytype > 0):
		tileytype = tileytype + 1
		pass
	if (tilextype < 0):
		tilextype = tilextype - 1
		pass
	
	
	#tileX = (yPos / tile_height) + (xPos / tile_width);
	#tileY = (xPos / tile_width) - (yPos / tile_height);
	
	
#	tilextype =
#	tileytype =
	
	#--------------ON AND OFF INPUT FOR DEBUG TOOLS--------------------------
	
	if ((Input.is_action_pressed("Debug Tools")) && debugtools == 0):
		debugtools = 1
		pass
	elif ((Input.is_action_pressed("Debug Tools")) && debugtools == 1):
		debugtools = 0
		pass
	
	#------------------------------------------------------------------------
	
	#-----Printing Tile coordinates after dividing out the x and y lengths (eg 26 pixels for x axis, and 14 pixels for y axis)
	#-----Through Debug Tools------------------------------------------------
	#------------------------------------------------------------------------
	
	
	if (debugtools == 1):
		print("To TILE: ", tilextype, ", ", tileytype)
		var Precoordinates = str("To TILE: ", tilextype, ", ", tileytype)
		Precoor.set_text(Precoordinates)
		pass
	else:
		var Precoordinates = str(" ")
		Precoor.set_text(Precoordinates)
		pass
	
	tilextype = int(tilextype)
	tileytype = int(tileytype)
	
	#------------------------------------------------------------------------
	#------Mouse Coordinates plus--------------------------------------------
	#------Tile coordinate printed through debug tools after being adjusted for isometric axis
	#------------------------------------------------------------------------
	
	if (debugtools == 1):
		print(clickx, ", ", clicky, ": Tile: ", tilextype, ", ", tileytype)
		var Postcoordinates = str(clickx, ", ", clicky, ": Tile: ", tilextype, ", ", tileytype)
		Postcoor.set_text(Postcoordinates)
		pass
	else:
		var Postcoordinates = str(" ")
		Postcoor.set_text(Postcoordinates)
		pass
	
	
	#-------Mouse Actions--------
	
	if (Input.is_action_pressed("Left_mouse")):
		set_cell(tilextype, tileytype, 2)
		pass
	if (Input.is_action_pressed("Right_mouse")):
		set_cell(tilextype, tileytype, 3)
		pass
	
	pass
