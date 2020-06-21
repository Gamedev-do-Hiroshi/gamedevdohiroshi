extends Node2D

var state = 0
var number_of_options = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#const scenes = [$Figuras/Basquete/Selected, $Figuras/Basquete1/Selected]
# $Figuras/Basquete3/Selected, $Figuras/Floresta/Selected, $Figuras/Floresta1/Selected, $Figuras/Floresta3/Selected, $Figuras/Vinicola/Selected, $Figuras/Vinicola1/Selected, $Figuras/Vinicola3/Selected]

# Called when the node enters the scene tree for the first time.
func _ready():
#	seta.rect_scale = Vector2(0.4, 0.4)
	#defstate()
	pass # Replace with function body.

#func defstate():
#	if(state == 0):
#		seta.rect_position.y = new_game.rect_position.y
#	elif(state == 1):
#		seta.rect_position.y = options.rect_position.y
#	elif(state == 2):
#		seta.rect_position.y = credits.rect_position.y
#	elif(state == 3):
#		seta.rect_position.y = quit_game.rect_position.y
		
#	seta.rect_position.y += 24
#	pass

func _process(delta):
	if state == 0:
		$Figuras/Basquete1/Selected.visible = true
	else:
		$Figuras/Basquete1/Selected.visible = false
	
	if state == 1:
		$Figuras/Vinicola1/Selected.visible = true
	else:
		$Figuras/Vinicola1/Selected.visible = false
	
	if state == 2:
		$Figuras/Floresta1/Selected.visible = true
	else:
		$Figuras/Floresta1/Selected.visible = false
	
	if state == 3:
		$Figuras/Basquete3/Selected.visible = true
	else:
		$Figuras/Basquete3/Selected.visible = false
	
	if state == 4:
		$Figuras/Vinicola3/Selected.visible = true
	else:
		$Figuras/Vinicola3/Selected.visible = false
	
	if state == 5:
		$Figuras/Floresta3/Selected.visible = true
	else:
		$Figuras/Floresta3/Selected.visible = false
	
	if state == 6:
		$Figuras/Basquete/Selected.visible = true
	else:
		$Figuras/Basquete/Selected.visible = false
	
	if state == 7:
		$Figuras/Vinicola/Selected.visible = true
	else:
		$Figuras/Vinicola/Selected.visible = false
	
	if state == 8:
		$Figuras/Floresta/Selected.visible = true
	else:
		$Figuras/Floresta/Selected.visible = false
	
	
	#scenes[state].visible = true
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_UP:
			state = (state + 6)%9
		elif event.pressed and event.scancode == KEY_DOWN:
			state = (state + 3)%9
		elif event.pressed and event.scancode == KEY_LEFT:
			state = 3*(state/3) + (state + 2)%3
		elif event.pressed and event.scancode == KEY_RIGHT:
			state =  3*(state/3) + (state + 1)%3
		elif event.pressed and event.scancode == KEY_ENTER:
			if state == 0:
#				var scene = load("res://Basquete.tscn")
#				var basquete = scene.instance()
#				add_child(basquete)
				get_tree().change_scene("res://Basquete.tscn")
			elif state == 1:
				get_tree().change_scene("res://Floresta.tscn")	
			elif state == 2:
				get_tree().change_scene("res://Vinicula.tscn")			
	#defstate()
	pass

