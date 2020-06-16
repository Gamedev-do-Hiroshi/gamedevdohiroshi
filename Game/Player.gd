extends RigidBody2D

export var player = 1
var x
var y
var vx
var vy
var chao
var g = 100


func _ready():
	if player == 1:
		$Animacao.animation = "Player 1"
	elif player == 2:
		$Animacao.animation = "Player 2"
	pass 
	
	self.mode = MODE_CHARACTER
	
	x = 0
	y = 0
	vx = 0
	vy = 0
	chao = 0

func _input(event):
	if player == 1:
		if event is InputEventKey:
			if event is InputEventKey:
				if event.pressed and event.scancode == 68: #definir cada tecla como constante tipo 68 = KEY_D
					self.linear_velocity.x = 100
				if !event.pressed and event.scancode == 68:
					self.linear_velocity.x = 0
				if event.pressed and event.scancode == 65:#KEY_A
					self.linear_velocity.x = -100
				if !event.pressed and event.scancode == 65:
					self.linear_velocity.x = 0
					
				if event.pressed and event.scancode == 87: #KEY_W
					if chao != 0:
						self.linear_velocity.y = -200
	elif player == 2:
		if event is InputEventKey:
			if event is InputEventKey:
				if event.pressed and event.scancode == 16777233: #KEY_RIGHT
					self.linear_velocity.x = 100
				if !event.pressed and event.scancode == 16777233:
					self.linear_velocity.x = 0
				if event.pressed and event.scancode == 16777231: #KEY_LEFT
					self.linear_velocity.x = -100
				if !event.pressed and event.scancode == 16777231:
					self.linear_velocity.x = 0
	
				if event.pressed and event.scancode == 16777232: #KEY_UP
					if chao != 0:
						self.linear_velocity.y = -200
						
	if event is InputEventKey:
		print(event.scancode)
	
	pass
	
func _integrate_forces(state):	

	self.angular_velocity = 0
	self.applied_torque = 0
	

func _process(delta):
	
	if( abs(self.linear_velocity.y) < 1 ):
		self.linear_velocity.y = -1
	
	#self.rotation_degrees = 0
	#self.
	
#	if !chao:
#		vy += g*delta
#	elif vy > 0:
#		vy = 0
#
#	self.position.x += vx * delta;
#	self.position.y += vy * delta;
	#self.position.y = y;
	
	
	pass



func _on_Pes_area_entered(area):
	print(area.get_groups()) 
	if area.get_groups().has("plataforma"):
		chao += 1


func _on_Pes_area_exited(area):
	print(area.get_groups()) 
	if area.get_groups().has("plataforma"):
		chao -= 1
