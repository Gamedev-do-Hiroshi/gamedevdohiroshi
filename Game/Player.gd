extends Area2D

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
	x = 0
	y = 0
	vx = 0
	vy = 0

func _input(event):
	if player == 1:
		if event is InputEventKey:
			if event is InputEventKey:
				if event.pressed and event.scancode == 68: #definir cada tecla como constante tipo 68 = KEY_D
					vx = 100
				if !event.pressed and event.scancode == 68:
					vx = 0
				if event.pressed and event.scancode == 65:#KEY_A
					vx = -100
				if !event.pressed and event.scancode == 65:
					vx = 0
					
				if event.pressed and event.scancode == 87: #KEY_W
					if chao:
						vy = -100
	elif player == 2:
		if event is InputEventKey:
			if event is InputEventKey:
				if event.pressed and event.scancode == 16777233: #KEY_RIGHT
					vx = 100
				if !event.pressed and event.scancode == 16777233:
					vx = 0
				if event.pressed and event.scancode == 16777231: #KEY_LEFT
					vx = -100
				if !event.pressed and event.scancode == 16777231:
					vx = 0
	
				if event.pressed and event.scancode == 16777232: #KEY_UP
					if chao:
						vy = -100
	
	if event is InputEventKey:
		print(event.scancode)
	
	pass
func _process(delta):
	
	
	if !chao:
		vy += g*delta
	elif vy > 0:
		vy = 0
	
	self.position.x += vx * delta;
	self.position.y += vy * delta;
	#self.position.y = y;
	
	#print(delta)
	
	
	
	pass



func _on_Player_area_entered(area):
	print(area.get_groups()) 
	if area.get_groups().has("plataforma"):
		print("AAAAAAAA")
		chao = 1
		


func _on_Player_area_exited(area):
	print(area.get_groups()) 
	if area.get_groups().has("plataforma"):
		print("BBBBBB")
		chao = 0
	
