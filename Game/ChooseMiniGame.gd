extends Node2D

enum PODERES {VERMELHO, LARANJA, AZUL, GELO, AMARELO, ROXO, VERDE, ESPINHO}

var mapa_escolhido = -1
var mapa = 0
var state = 0
var number_of_options = 2
var poder1 = 0
var poder2 = 0
var poder1Escolhido = -1
var poder2Escolhido = -1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#const scenes = [$Figuras/Basquete/Selected, $Figuras/Basquete1/Selected]
# $Figuras/Basquete3/Selected, $Figuras/Floresta/Selected, $Figuras/Floresta1/Selected, $Figuras/Floresta3/Selected, $Figuras/Vinicola/Selected, $Figuras/Vinicola1/Selected, $Figuras/Vinicola3/Selected]

# Called when the node enters the scene tree for the first time.
func _ready():
	moveSelectedPower()
#	seta.rect_scale = Vector2(0.4, 0.4)
	#defstate()
	pass # Replace with function body.

var poder_lista = [$Poderes/BolaNeve, $Poderes/BolaTerra, $Poderes/garrafa, $Poderes/laser, $Poderes/BolaFogo]

func moveSelectedPower():
	if poder1 == 0:
		$Poderes/BolaNeve/Selected1.visible = true
	else:
		$Poderes/BolaNeve/Selected1.visible = false
	
	if poder1 == 1:
		$Poderes/BolaTerra/Selected1.visible = true
	else:
		$Poderes/BolaTerra/Selected1.visible = false
	
	if poder1 == 2:
		$Poderes/garrafa/Selected1.visible = true
	else:
		$Poderes/garrafa/Selected1.visible = false
	
	if poder1 == 3:
		$Poderes/laser/Selected1.visible = true
	else:
		$Poderes/laser/Selected1.visible = false
	
	if poder1 == 4:
		$Poderes/BolaFogo/Selected1.visible = true
	else:
		$Poderes/BolaFogo/Selected1.visible = false
		
	if poder2 == 0:
		$Poderes/BolaNeve/Selected2.visible = true
	else:
		$Poderes/BolaNeve/Selected2.visible = false
	
	if poder2 == 1:
		$Poderes/BolaTerra/Selected2.visible = true
	else:
		$Poderes/BolaTerra/Selected2.visible = false
	
	if poder2 == 2:
		$Poderes/garrafa/Selected2.visible = true
	else:
		$Poderes/garrafa/Selected2.visible = false
	
	if poder2 == 3:
		$Poderes/laser/Selected2.visible = true
	else:
		$Poderes/laser/Selected2.visible = false
	
	if poder2 == 4:
		$Poderes/BolaFogo/Selected2.visible = true
	else:
		$Poderes/BolaFogo/Selected2.visible = false
		
	if mapa_escolhido != -1 and poder1Escolhido != -1 and poder2Escolhido != -1:
		if poder1Escolhido == 0:
			poder1Escolhido = PODERES.AZUL
		elif poder1Escolhido == 1:
			poder1Escolhido = PODERES.VERDE
		elif poder1Escolhido == 2:
			poder1Escolhido = PODERES.ROXO
		elif poder1Escolhido == 3:
			poder1Escolhido = PODERES.AMARELO
		elif poder1Escolhido == 4:
			poder1Escolhido = PODERES.VERMELHO
			
		if poder2Escolhido == 0:
			poder2Escolhido = PODERES.AZUL
		elif poder2Escolhido == 1:
			poder2Escolhido = PODERES.VERDE
		elif poder2Escolhido == 2:
			poder2Escolhido = PODERES.ROXO
		elif poder2Escolhido == 3:
			poder2Escolhido = PODERES.AMARELO
		elif poder2Escolhido == 4:
			poder2Escolhido = PODERES.VERMELHO
		
		
		if mapa_escolhido == 0:
			# Remove the current level
			var root = get_tree().get_root()
	
			for x in root.get_children():
				print(x.name)
	
			var atual = root.get_node("ChooseMiniGame")
			root.remove_child(atual)
			atual.call_deferred("free")

			for x in root.get_children():
				print("Carai")
				print(x.name)
	

			# Add the next level
			var basquete_resource = load("res://Basquete.tscn")
			var basquete = basquete_resource.instance()
			
			basquete.get_node("Player 1").poder = poder1Escolhido
			basquete.get_node("Player 2").poder = poder2Escolhido
			
			root.add_child(basquete)
			
			#get_tree().change_scene("res://Basquete.tscn")
			#print(get_tree().get_current_scene())
			#print("oi")
			#get_tree().get_current_scene().player1.poder = poder1Escolhido
			#get_tree().get_current_scene().player2.poder = poder2Escolhido
		elif state == 1:
			var scene = load("res://Floresta.tscn")
		
			var basquete = scene.instance()
			get_tree().get_root().add_child(basquete)
			basquete.player1.poder = poder1Escolhido
			basquete.player2.poder = poder2Escolhido
			
			var atual = get_tree().get_root().get_node("ChooseMiniGame")
			get_tree().get_root().remove_child(atual)
			atual.call_deferred("free")
		elif state == 2:
			var scene = load("res://Vinicula.tscn")
		
			var basquete = scene.instance()
			get_tree().get_root().add_child(basquete)
			basquete.player1.poder = poder1Escolhido
			basquete.player2.poder = poder2Escolhido
			
			
			var atual = get_tree().get_root().get_node("ChooseMiniGame")
			get_tree().get_root().remove_child(atual)
			atual.call_deferred("free")
			
		mapa_escolhido = -1
			
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
	
	moveSelectedPower()
	#scenes[state].visible = true
	pass

func _input(event):
	
	print(mapa_escolhido)
	
	if mapa_escolhido != -1:
		
		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_LEFT:
				poder1 = (poder1 + 4)%5
			elif event.pressed and event.scancode == KEY_RIGHT:
				poder1 = (poder1 + 1)%5
			elif event.pressed and event.scancode == KEY_ENTER:
				poder1Escolhido = poder1
			elif event.pressed and event.scancode == KEY_A:
				poder2 = (poder2 + 4)%5
			elif event.pressed and event.scancode == KEY_D:
				poder2 = (poder2 + 1)%5
			elif event.pressed and event.scancode == KEY_SPACE:
				poder2Escolhido = poder2
		
	else:
		
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
				print(state)
				mapa_escolhido = state
				print(mapa_escolhido)
				
	moveSelectedPower()
	pass

