extends CanvasItem

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var Precoor = get_node("Pre-coordinates")
onready var Postcoor = get_node("Post-coordinates")
onready var SelMap = get_node("VISIBLE SELECTION")
onready var KEYTIMERNODE = get_node("/root/Node2D/KeyTimer")
onready var DISPLAYMap = get_node("/root/Node2D/Selection map")
onready var CAMERATIMER = get_node("/root/Node2D/CameraSelectionTimer")
onready var CAMERA2D = get_node("/root/Node2D/Camera2D")



const SAVE_PATH = "res://save.json"

var savedict = {}


var clickx #= Vector2()
var clicky #= Vector2()
var tilextype = 0
var tileytype = 0
var oldtilextype = 0
var oldtileytype = 0
var tiletypeforplace = -2
var eqy = 15
var eqx = 27
var debugtools = 0
var buttonhover = 0
var Keytimer = 0
var DebugTimer = 0
var TileisSelected = 0
var Save_X = 0
var Save_Y = 0
var TILE_ID_SAVE
var SaveBlockIteration = 1
var Save_Tile_ID = 1
var Camera_Selection_Timer = 0
var startingcamposx
var startingcamposy
var move_up = Vector2()
var move_right = Vector2()
var move_down = Vector2()
var move_left = Vector2()
var CameraPos = Vector2(0,0)
var CameraMovementSpeed = 2.5

#Arrays
var XSAVEARRAY = []
var YSAVEARRAY = []
var IDSAVEARRAY = []

func _ready():
	
	set_fixed_process(true)
	pass

func _fixed_process(delta): #_ready():
	
	clickx = get_local_mouse_pos().x
	clicky = get_local_mouse_pos().y
	
	CAMERA2D.set_offset(CameraPos)
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
	
	if ((Input.is_action_pressed("Debug Tools")) && debugtools == 0 && Keytimer == 0):
		debugtools = 1
		Keytimer = 1
		KEYTIMERNODE.start()
		pass
	elif ((Input.is_action_pressed("Debug Tools")) && debugtools == 1 && Keytimer == 0):
		debugtools = 0
		Keytimer = 1
		KEYTIMERNODE.start()
		pass
	
	#------------------------------------------------------------------------
	
	#-----Printing Tile coordinates after dividing out the x and y lengths (eg 26 pixels for x axis, and 14 pixels for y axis)
	#-----Through Debug Tools------------------------------------------------
	#------------------------------------------------------------------------
	
	
	if (debugtools == 1 && DebugTimer == 0):
		print("To TILE: ", tilextype, ", ", tileytype)
		var Precoordinates = str("To TILE: ", tilextype, ", ", tileytype)
		Precoor.set_text(Precoordinates)
		pass
	elif(debugtools == 0):
		var Precoordinates = str(" ")
		Precoor.set_text(Precoordinates)
		pass
	
	tilextype = int(tilextype)
	tileytype = int(tileytype)
	
	#------------------------------------------------------------------------
	#------Mouse Coordinates plus--------------------------------------------
	#------Tile coordinate printed through debug tools after being adjusted for isometric axis
	#------------------------------------------------------------------------
	
	if (debugtools == 1 && DebugTimer == 0):
		print(clickx, ", ", clicky, ": Tile: ", tilextype, ", ", tileytype)
		var Postcoordinates = str(clickx, ", ", clicky, ": Tile: ", tilextype, ", ", tileytype)
		Postcoor.set_text(Postcoordinates)
		DebugTimer = 1
		pass
	elif(debugtools == 0):
		var Postcoordinates = str(" ")
		Postcoor.set_text(Postcoordinates)
		pass
	
	#-------Mouse Actions--------
	
	if (Input.is_action_pressed("Left_mouse") && buttonhover == 0):
#		CAMERATIMER.start()
#		if (Camera_Selection_Timer == 1):
#			var ifcamloop = 1
#			
#			var clickcamx = get_global_mouse_pos().x
#			var clickcamy = get_global_mouse_pos().y
#			
#			var startingcamposx = clickcamx
#			var startingcamposy = clickcamy
#			
#			while(Camera_Selection_Timer == 1 && Input.is_action_pressed("Left_mouse") == true):
#				
#				
#				var CAMPOSX = CAMERA2D.get_camera_pos().x
#				var CAMPOSY = CAMERA2D.get_camera_pos().y
#				
#				clickcamx = get_global_mouse_pos().x
#				clickcamy = get_global_mouse_pos().y
#				
#				if(ifcamloop < 1):
#					
#					startingcamposx = clickcamx
#					startingcamposy = clickcamy
#				
#				var finalposcamx = startingcamposx - clickcamx
#				var finalposcamy = startingcamposy - clickcamy
#				
#				var finalposcam = Vector2(finalposcamx, finalposcamy)
#				
#				CAMERA2D.set_offset(finalposcam)
#				
#				
#				
#				pass
#			pass
		if(Camera_Selection_Timer == 0):
			SelMap.set_cell(oldtilextype, oldtileytype, -1)
			SelMap.set_cell(tilextype, tileytype, 3)
			oldtilextype = tilextype
			oldtileytype = tileytype
			TileisSelected = 1
		pass
	if (Input.is_action_pressed("Right_mouse") && buttonhover == 0):
		SelMap.set_cell(oldtilextype, oldtileytype, -1)
		TileisSelected = 0
		pass
	if (Input.is_action_pressed("move_up")):
		
		move_up = CameraPos + Vector2(0, -CameraMovementSpeed)
		
		CameraPos = move_up
		
#		CAMERA2D.set_offset(move_up)
		
		print(CAMERA2D.get_offset())
		
		
		pass
	if (Input.is_action_pressed("move_left")):
		
		
		move_left = CameraPos + Vector2(-CameraMovementSpeed, 0)
		
		CameraPos = move_left
		
#		CAMERA2D.set_offset(move_left)
		
		print(CAMERA2D.get_offset())
		
		pass
	if (Input.is_action_pressed("move_right")):
		
		move_right = CameraPos + Vector2(CameraMovementSpeed, 0)
		
		CameraPos = move_right
		
#		CAMERA2D.set_offset(move_right)
		
		print(CAMERA2D.get_offset())
		
		pass
	if (Input.is_action_pressed("move_bottom")):
		
		move_down = CameraPos + Vector2(0, CameraMovementSpeed)
		
		CameraPos = move_down
		
#		CAMERA2D.set_offset(move_down)
		
		print(CAMERA2D.get_offset())
		
		
		pass
	if (Input.is_action_pressed("Zoomin") && Keytimer == 0):
		
		Keytimer = 1
		KEYTIMERNODE.start()
		
		var zoomin = Vector2(0.15, 0.15)
		
		CAMERA2D.set_zoom(CAMERA2D.get_zoom() + zoomin)
		
		print (CAMERA2D.get_zoom())
		
		pass
	if (Input.is_action_pressed("Zoomout") && Keytimer == 0):
		
		Keytimer = 1
		KEYTIMERNODE.start()
		
		var zoomout = Vector2(-0.15, -0.15)
		
		CAMERA2D.set_zoom(CAMERA2D.get_zoom() + zoomout)
		
		print (CAMERA2D.get_zoom())
		
		pass
	
	pass


func _on_CameraSelectionTimer_timeout():
	Camera_Selection_Timer = 1
	CAMERATIMER.stop()
	pass # replace with function body


func _on_Tile_1_pressed():
#	if typeofsubject == 2:
#		print("Rocks Have Been DeSelected")
#		typeofsubject = 0
#		rockpress.set_normal_texture(rockstexture)
#	else:
#		typeofsubject = 2
#		print("Rocks Have Been Selected")
#		setmainbuttontexture()
#	
#	
#	if(tiletypeforplace == 0):
#		print("Tile 1 Has Been DeSelected")
#		tiletypeforplace = -2
#	else:
#		tiletypeforplace = 0
#		print("Tile 1 Has Been Selected")
	if(TileisSelected == 1):
		set_cell(oldtilextype, oldtileytype, 0)
		pass
		
	pass # replace with function body


func _on_Tile_2_pressed():
#	if(tiletypeforplace == 1):
#		print("Tile 2 Has Been DeSelected")
#		tiletypeforplace = -2
#	else:
#		tiletypeforplace = 1
#		print("Tile 2 Has Been Selected")
	if(TileisSelected == 1):
		set_cell(oldtilextype, oldtileytype, 1)
		pass
	
	pass # replace with function body


func _on_Tile_3_pressed():
#	if(tiletypeforplace == 2):
#		print("Tile 3 Has Been DeSelected")
#		tiletypeforplace = -2
#	else:
#		tiletypeforplace = 2
#		print("Tile 3 Has Been Selected")
	if(TileisSelected == 1):
		set_cell(oldtilextype, oldtileytype, 2)
		pass
	
	pass # replace with function body


func _on_Tile_Remove_pressed():
#	if(tiletypeforplace == -1):
#		print("Tile 1 Has Been DeSelected")
#		tiletypeforplace = -2
#	else:
#		tiletypeforplace = -1
#		print("Tile 1 Has Been Selected")
	if(TileisSelected == 1):
		set_cell(oldtilextype, oldtileytype, -1)
		pass
	
	pass # replace with function body


func _on_Tile_1_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Tile_1_mouse_exit():
	buttonhover = 0
	pass # replace with function body


func _on_Tile_2_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Tile_2_mouse_exit():
	buttonhover = 0
	pass # replace with function body


func _on_Tile_3_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Tile_3_mouse_exit():
	buttonhover = 0
	pass # replace with function body


func _on_Tile_Remove_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Tile_Remove_mouse_exit():
	buttonhover = 0
	pass # replace with function body

func _on_Save_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Save_mouse_exit():
	buttonhover = 0
	pass # replace with function body


func _on_Load_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Load_mouse_exit():
	buttonhover = 0
	pass # replace with function body


func _on_Reset_mouse_enter():
	buttonhover = 1
	pass # replace with function body


func _on_Reset_mouse_exit():
	buttonhover = 0
	pass # replace with function body



func _on_KeyTimer_timeout():
	print("KeyTimer Timeout")
	Keytimer = 0
	pass # replace with function body


func _on_DebugTimer_timeout():
	DebugTimer = 0
	pass # replace with function body

var X_Save_Distance = 0
var Y_Save_Distance = 0

func _on_Save_pressed():
	
#	Save_X = oldtilextype 
#	Save_Y = oldtileytype 
	
	X_Save_Distance = X_Save_Distance - 8
	Y_Save_Distance = Y_Save_Distance - 8
	
	XSAVEARRAY = []
	YSAVEARRAY = []
	IDSAVEARRAY = []
	
	while(SaveBlockIteration <= 289):
		
		
		if(X_Save_Distance <= 8):
			TILE_ID_SAVE = get_cell(X_Save_Distance, Y_Save_Distance)
			print(X_Save_Distance, ", ", Y_Save_Distance, ", ", TILE_ID_SAVE)
			XSAVEARRAY.append([X_Save_Distance])
			YSAVEARRAY.append([Y_Save_Distance])
			IDSAVEARRAY.append([TILE_ID_SAVE])
			X_Save_Distance += 1
			pass
		if(X_Save_Distance == 9):
			X_Save_Distance = -8
			Y_Save_Distance += 1
		SaveBlockIteration += 1
		pass
	
	SaveFunction()
	
	pass # replace with function body



func SaveFunction():
	
	savedict = {
		Save_X = XSAVEARRAY,
		Save_Y = YSAVEARRAY,
		Save_Tile_ID = IDSAVEARRAY
	}
	
	var save_file = File.new()
	if save_file.open("res://saved_game.sav", File.WRITE) != 0:
		print("Error opening file")
		return
	
	save_file.store_line(savedict.to_json())
	save_file.close()
	
	pass

var LoadBlockIteration = 0

func _on_Load_pressed():
	
	# Check if there is a saved file
	var save_file = File.new()
	if not save_file.file_exists("res://saved_game.sav"):
		print("No file saved!")
		return
	
	# Open existing file
	if save_file.open("res://saved_game.sav", File.READ) != 0:
		print("Error opening file")
		return
	
	# Get the data
	var savedict = {}
	savedict.parse_json(save_file.get_line())
	
#	print(savedict)
	
#	TILE_ID_SAVE = get_cell(X_Save_Distance, Y_Save_Distance)
#		Save_X = XSAVEARRAY,
#		Save_Y = YSAVEARRAY,
#		Save_Tile_ID = IDSAVEARRAY
	
	var Load_X #= XSAVEARRAY.find([1]) #XSAVEARRAY.append([X_Save_Distance])
	var Load_Y #= YSAVEARRAY.find([1])
	var Load_ID #= IDSAVEARRAY.find([1])
	
	LoadBlockIteration = 0
	
	while(LoadBlockIteration <= 288):
		
#		Load_X = savedict.Save_X[LoadBlockIteration]
#		Load_Y = savedict.Save_Y[LoadBlockIteration]
#		Load_ID = savedict.Save_Tile_ID[LoadBlockIteration]
		
		Load_X = str(savedict.Save_X[LoadBlockIteration])
		Load_Y = str(savedict.Save_Y[LoadBlockIteration])
		Load_ID = str(savedict.Save_Tile_ID[LoadBlockIteration])
		
		
		Load_X = int(Load_X)
		Load_Y = int(Load_Y)
		Load_ID = int(Load_ID)
		
		print("Loading Values|X-Value: ", Load_X, ", Y-Value: ", Load_Y, ", ID-Value: ", Load_ID)
		
		set_cell(Load_X, Load_Y, Load_ID)
		
		LoadBlockIteration += 1
		
		pass
	
	LoadBlockIteration = 1
	
	pass # replace with function body








func _on_Load1_pressed():
	
	SaveBlockIteration = 1
	X_Save_Distance = -8
	Y_Save_Distance = -8
	
	
	while(SaveBlockIteration <= 289):
		
		
		if(X_Save_Distance <= 8):
			set_cell(X_Save_Distance, Y_Save_Distance, -1)
			X_Save_Distance += 1
			pass
		if(X_Save_Distance == 9):
			X_Save_Distance = -8
			Y_Save_Distance += 1
		SaveBlockIteration += 1
		pass
	
	
	pass # replace with function body




