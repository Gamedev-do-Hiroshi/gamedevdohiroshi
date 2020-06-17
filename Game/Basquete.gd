extends Node2D



func _ready():
	pass

func _process(delta):
	#print($Bola.rotation)
	
	pass


func _on_Cesta1_body_exited(body):
	print(body)
	pass # Replace with function body.


func _on_Cesta1_body_entered(body):
	print(body)
	print(body.get_groups())
	pass # Replace with function body.
