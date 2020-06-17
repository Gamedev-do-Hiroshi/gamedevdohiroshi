extends RigidBody2D

func _ready():
	pass

func _integrate_forces( state ):
	#print(state)
	if(state.get_contact_count() >= 1):  
		print(state.get_contact_local_pos(0))
