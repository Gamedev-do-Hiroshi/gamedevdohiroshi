extends Control

func _ready():
	visible = false
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pause"):
		pause()

func pause():
  var new_state = not get_tree().paused
  get_tree().paused = new_state
  visible = new_state

func _on_TextureButton_pressed():
	pause()
	print("here 11")

func _on_TextureButton2_pressed():
	print("here 22")
	
func _on_TextureButton3_pressed():
	get_tree().change_scene("res://ChooseMiniGame.tscn")
	visible = false
	get_tree().paused = false
