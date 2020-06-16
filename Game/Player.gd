extends KinematicBody2D

export var player = 1

const UP = Vector2(0, -1)
const SPEED = 200
const GRAVITY = 24
const JUMP_HEIGHT = -600
var motion = Vector2()
var sentido = -1

const VEL_SOCO = 100
const TEMPO_SOCO = 0.2
var soco = 0
var tempo_soco = 0.0
var vel_soco = 0.0
var teste

func _ready():

#	if player == 1:
#		$Animacao.animation = "Player 1"
#	elif player == 2:
#		$Animacao.animation = "Player 2"
	soco = 0
	sentido = -1


func _physics_process(delta):
	motion.y += GRAVITY
	
	if player == 1:
	
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			sentido = 1
			$Sprite.flip_h = true
			#$Sprite.play("Run")
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			sentido = -1
			$Sprite.flip_h = false
			#$Sprite.play("Run")
		else:
			motion.x = 0
			#$Sprite.play("Idle")
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
		#else:
			#$Sprite.play("Jump")
			
		if Input.is_key_pressed(KEY_ENTER):
			punch()
		
	
		motion = move_and_slide(motion, UP)
		pass
		
	elif player == 2:
		
		if Input.is_key_pressed(KEY_D):
			motion.x = SPEED
			sentido = 1
			$Sprite.flip_h = true
			#$Sprite.play("Run")
		elif Input.is_key_pressed(KEY_A):
			motion.x = -SPEED
			sentido = -1
			$Sprite.flip_h = false
			#$Sprite.play("Run")
		else:
			motion.x = 0
			#$Sprite.play("Idle")
		
		if is_on_floor():
			if Input.is_key_pressed(KEY_W):
				motion.y = JUMP_HEIGHT
		#else:
			#$Sprite.play("Jump")
	
		motion = move_and_slide(motion, UP)
		
	if soco != 0:
		tempo_soco += delta
	
	if soco == 1 and tempo_soco >= TEMPO_SOCO/2:
		soco = 2
		vel_soco = - vel_soco
	elif soco == 2 and tempo_soco >= TEMPO_SOCO:
		soco = 0
		vel_soco = 0;
		$Mao.position.x = 0
		tempo_soco = 0
	
	if soco == 1:
		$Mao.position = sign(vel_soco) * sentido * $Mao.position 
		vel_soco = sentido * VEL_SOCO
		
	elif soco == 2:
		$Mao.position = - sign(vel_soco) * sentido * $Mao.position 
		vel_soco = - sentido * VEL_SOCO
	
	if soco != 0:
		$Mao.position = $Mao.position + Vector2(vel_soco*delta, 0)
		#$Mao.position = Vector2(10,10)
	#$Mao/Sprite.position = $Mao/Colisao.position
	
	#print(soco)
	print($Mao.position)
	print(tempo_soco)
	print(vel_soco)
		
	pass

func punch():
	if soco == 0:
		soco = 1
		tempo_soco = 0.0
		vel_soco = sentido * VEL_SOCO
		#print(soco)
		#print(teste)
		print("SOCO")


#func _process()
#export var player = 1
#var x
#var y
#var vx
#var vy
#var chao
#var g = 100

#const SPEED = 200
#const JUMP_SPEED = 500

#func _ready():
#	if player == 1:
#		$Animacao.animation = "Player 1"
#	elif player == 2:
#		$Animacao.animation = "Player 2"
	
#	self.mode = MODE_CHARACTER
	
#	y = 0
#	vx = 0
#	vy = 0
#	chao = 0

#func _input(event):
#	if player == 1:
#		if event is InputEventKey:
#			if event is InputEventKey:
#				if event.pressed and event.scancode == 68: #definir cada tecla como constante tipo 68 = KEY_D
#					self.linear_velocity.x = SPEED
#				if !event.pressed and event.scancode == 68:
#					self.linear_velocity.x = 0
#				if event.pressed and event.scancode == 65:#KEY_A
#					self.linear_velocity.x = -SPEED
#				if !event.pressed and event.scancode == 65:
#					self.linear_velocity.x = 0
#					
#				if event.pressed and event.scancode == 87: #KEY_W
#					if chao != 0:
#						self.linear_velocity.y = -JUMP_SPEED
#	elif player == 2:
#		if event is InputEventKey:
#			if event is InputEventKey:
#				if event.pressed and event.scancode == 16777233: #KEY_RIGHT
#					self.linear_velocity.x = SPEED
#				if !event.pressed and event.scancode == 16777233:
#					self.linear_velocity.x = 0
#				if event.pressed and event.scancode == 16777231: #KEY_LEFT
#					self.linear_velocity.x = -SPEED
#				if !event.pressed and event.scancode == 16777231:
#					self.linear_velocity.x = 0
	
#				if event.pressed and event.scancode == 16777232: #KEY_UP
#					if chao != 0:
#						self.linear_velocity.y = -JUMP_SPEED
						
#	if event is InputEventKey:
#		print(event.scancode)
	
#	pass
	
#func _integrate_forces(state):	

#	self.angular_velocity = 0
#	self.applied_torque = 0
	

#func _process(delta):
	
#	if( abs(self.linear_velocity.y) < 1 ):
#		self.linear_velocity.y = -1
	
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
	
	
#	pass



#func _on_Pes_area_entered(area):
#	print(area.get_groups()) 
#	if area.get_groups().has("plataforma"):
#		chao += 1


#func _on_Pes_area_exited(area):
#	print(area.get_groups()) 
#	if area.get_groups().has("plataforma"):
#		chao -= 1
