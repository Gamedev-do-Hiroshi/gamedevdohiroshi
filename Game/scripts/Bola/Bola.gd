extends RigidBody2D

func _ready():
	pass

func _integrate_forces( state ):
	#print(state)
	if(state.get_contact_count() >= 1):  
		print(state.get_contact_local_pos(0))

func _physics_process(delta):
	#print(position.x)
	#print(position.y)
	pass

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
