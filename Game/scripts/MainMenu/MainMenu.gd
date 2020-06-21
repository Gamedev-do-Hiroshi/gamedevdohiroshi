extends Node2D

onready var seta = $MarginContainer/HBoxContainer/Seta
onready var new_game = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/NewGame
onready var options = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Options
onready var credits = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/Credits
onready var quit_game = $MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/QuitGame
onready var roleta = $Roleta
var state = 0
var number_of_options = 4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	seta.rect_scale = Vector2(0.4, 0.4)
	defstate()
	pass # Replace with function body.

func defstate():
	if(state == 0):
		seta.rect_position.y = new_game.rect_position.y
	elif(state == 1):
		seta.rect_position.y = options.rect_position.y
	elif(state == 2):
		seta.rect_position.y = credits.rect_position.y
	elif(state == 3):
		seta.rect_position.y = quit_game.rect_position.y
		
#	seta.rect_position.y += 24
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_UP:
			state -= 1
		elif event.pressed and event.scancode == KEY_DOWN:
			state += 1
		elif event.pressed and event.scancode == KEY_ENTER:
			if state == 0:
#				var scene = load("res://Basquete.tscn")
#				var basquete = scene.instance()
#				add_child(basquete)
				get_tree().change_scene("res://Basquete.tscn")
			elif state == 3:
				get_tree().quit()
	state = state % number_of_options
	if(state < 0):
		state += number_of_options
	defstate()
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	roleta.rotation += delta
#	if Input.is_action_pressed("ui_up"):
#		state += 1
#	elif Input.is_action_pressed("ui_down"):
#		state -= 1
#	state = state % 3
#	if(state < 0):
#		state += 3
#
#	defstate()
	
	pass
