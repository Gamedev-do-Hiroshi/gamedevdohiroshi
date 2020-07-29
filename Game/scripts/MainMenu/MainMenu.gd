extends Node2D

onready var logo = $Logo
onready var menu = $MarginContainer/MenuOptions
onready var seta = $Seta
onready var new_game = $MarginContainer/MenuOptions/NewGame
onready var options = $MarginContainer/MenuOptions/Options
onready var credits = $MarginContainer/MenuOptions/Credits
onready var quit_game = $MarginContainer/MenuOptions/QuitGame
onready var roleta = $Roleta
onready var roleta2 = $Roleta2
var state = 0
var number_of_options = 4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	logo.play();
	seta.rect_position.x = 415
	seta.rect_position.y = new_game.rect_position.y + menu.rect_position.y
	defstate()
	pass # Replace with function body.

func defstate():
	if(state == 0):
		seta.rect_position.y = new_game.rect_position.y + menu.rect_position.y
	elif(state == 1):
		seta.rect_position.y = options.rect_position.y + menu.rect_position.y
	elif(state == 2):
		seta.rect_position.y = credits.rect_position.y + + menu.rect_position.y
	elif(state == 3):
		seta.rect_position.y = quit_game.rect_position.y + + menu.rect_position.y
		
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

				var scene = load("res://ChooseMiniGame.tscn")
		
				var basquete = scene.instance()
				get_tree().get_root().add_child(basquete)

				var atual = get_tree().get_root().get_node("MainMenu")
				get_tree().get_root().remove_child(atual)
				atual.call_deferred("free")
		
			elif state == 3:
				get_tree().quit()
	state = state % number_of_options
	if(state < 0):
		state += number_of_options
	defstate()
	pass



func _process(delta):
	roleta.rotation += delta
	roleta2.rotation += delta
	pass
