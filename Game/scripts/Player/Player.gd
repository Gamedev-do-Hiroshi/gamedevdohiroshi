extends KinematicBody2D

export var player = 1
export(int, "VERMELHO", "LARANJA", "AZUL") var poder = "VERMELHO"

const UP = Vector2(0, -1)
const SPEED = 400
const GRAVITY = 24
const JUMP_HEIGHT = -600
const KB_SPEED = 400
const KB_TIME = 0.2
var motion = Vector2()
var sentido = -1

const VEL_SOCO = 100
const TEMPO_SOCO = 0.4
var soco = 0
var tempo_soco = 0.0
var vel_soco = 0.0
var teste

var vida = 100
var mana = 100
const TAXA_MANA = 50
const VEL_KNOCK_BACK = 200
const DURACAO_KNOCK_BACK = 0.2
var knock_back
var tempo_knock_back

var vel_colisao = Vector2()
var colisao = 0
var bola
var normal = Vector2()

var cena_poder
var novo_poder

# --------------------------------------> FUNÇÃO CHAMADA QUANDO CARREGA O NÓ <-----------------------------------------
func _ready():

#	if player == 1:
#		$Animacao.animation = "Player 1"
#	elif player == 2:
#		$Animacao.animation = "Player 2"
	soco = 0
	sentido = -1
	vida = 100
	mana = 100
	knock_back = 0
	colisao = 0
	
# --------------------------------------> FUNÇÃO CHAMADA A CADA FRAME <-----------------------------------------
func _process(delta):
	
	if vida <= 0:
		self.free()
	
	mana += TAXA_MANA * delta
	
	if mana > 100:
		mana = 100
	
	
	pass


# ---------------------------------------------------> FÍSICA <---------------------------------------------------------
func _physics_process(delta):
	
	motion.y += GRAVITY
	
	
	if knock_back == 0:
		control(delta)
		socar(delta)
	else:
		empurrao(delta)
		
	
	if colisao:
		motion = vel_colisao
	
	#print(motion)
	motion = move_and_slide(motion, UP)
		
	pass


# -------------------------------------------------------> SOCO <------------------------------------------------------
func punch():
	if soco == 0:
		soco = 1
		tempo_soco = 0.0
		vel_soco = sentido * VEL_SOCO
		$Sprite.play("Punch")
		#print(soco)
		#print(teste)
		print("SOCO")

func socar(delta): 
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
		$Sprite.play("Idle")
	
	if soco == 1:
		$Mao.position = sign(vel_soco) * sentido * $Mao.position 
		vel_soco = sentido * VEL_SOCO
		
	elif soco == 2:
		$Mao.position = - sign(vel_soco) * sentido * $Mao.position 
		vel_soco = - sentido * VEL_SOCO
	
	if soco != 0:
		$Mao.position = $Mao.position + Vector2(vel_soco*delta, 0)

func socado(direcao):
	if knock_back != 0:
		pass
	knock_back = direcao
	tempo_knock_back = 0.0
	motion.x = direcao * VEL_KNOCK_BACK

func empurrao(delta):
	
	
	tempo_knock_back += delta
	
	if tempo_knock_back >= DURACAO_KNOCK_BACK:
		knock_back = 0
		motion.x = 0
	
	pass

# -----------------------------------------------------> BASQUETE <-----------------------------------------------------

func colide():
	#kkkk nunca usei
	pass

# -----------------------------------------------------> CONTROLES <----------------------------------------------------
func control(delta):
	
	if player == 1:
	
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			sentido = 1
			$Sprite.flip_h = true
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			sentido = -1
			$Sprite.flip_h = false
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		else:
			motion.x = 0
			if soco == 0:
				$Sprite.play("Idle")
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
		#else:
			#$Sprite.play("Jump")
			
		if Input.is_key_pressed(KEY_ENTER):
			punch()
		
		if Input.is_key_pressed(KEY_L):
			ativar_poder()
		

		pass
		
	elif player == 2:
		
		if Input.is_key_pressed(KEY_D):
			motion.x = SPEED
			sentido = 1
			$Sprite.flip_h = true
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		elif Input.is_key_pressed(KEY_A):
			motion.x = -SPEED
			sentido = -1
			$Sprite.flip_h = false
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		else:
			motion.x = 0
			if soco == 0:
				$Sprite.play("Idle")
		
		if is_on_floor():
			if Input.is_key_pressed(KEY_W):
				motion.y = JUMP_HEIGHT
				
		#else:
			#$Sprite.play("Jump")
			
		if Input.is_key_pressed(KEY_SPACE):
			punch()
	
		if Input.is_key_pressed(KEY_Q):
			ativar_poder()
# ------------------------------------------------------> PODERES <-----------------------------------------------------
func ativar_poder():
	
	if mana < 100:
		return
	mana -= 100
	
	cena_poder = load("res://Poderes.tscn")
	novo_poder = cena_poder.instance()
	novo_poder.poder = poder
	novo_poder.sentido = sentido
	novo_poder.velocidade = motion
	if poder == 0:
		novo_poder.position = position +  Vector2(sentido*30, -10)
	elif poder == 2:
		novo_poder.position = position +  Vector2(sentido*50, -10)
	
	self.get_parent().add_child(novo_poder)
	pass

func gelado():
	
	cena_poder = load("res://Poderes.tscn")
	novo_poder = cena_poder.instance()
	novo_poder.poder = 3
	#novo_poder.sentido = sentido
	#novo_poder.velocidade = motion
	#novo_poder.position = position
	
	self.add_child(novo_poder)
	
	
	pass

# ------------------------------------------------------> SINAIS <------------------------------------------------------

func _on_Mao_area_entered(area):
	print(String(player) + " " + String(area.get_groups()) + " soco = " + String(soco)) 
	
	if(soco == 0):
		pass
	
	if ((area.get_groups().has("mao") or area.get_groups().has("corpo"))  and area.get_parent() != self):
		print("SOQUEI")
		area.get_parent().vida -= 10
		area.get_parent().socado(sentido)
	
	
	pass


func _on_Corpo_body_entered(body):
	print(body)
	if body.get_groups().has("bola"):
		normal = (position - body.position).normalized()
		vel_colisao = normal * 200	
		body.apply_central_impulse(200*normal * motion.dot(normal))
		print(200*normal * motion.dot(normal))
		bola = body
		colisao = 1
		#print(vel_colisao)
	
	pass # Replace with function body.


func _on_Corpo_body_exited(body):
	if body.get_groups().has("bola"):
		colisao = 0
	pass # Replace with function body.


func _on_Mao_body_entered(body):
	if body.get_groups().has("bola"):
		normal = ((position+ $Mao.position) - body.position).normalized()
		vel_colisao = normal * 200	
		body.apply_central_impulse(200*normal * (motion + Vector2(vel_soco, 0)).dot(normal) + Vector2(0, -80000))
		print("PPP")
		print(200*normal * (motion + Vector2(vel_soco, 0)).dot(normal))
		bola = body
		colisao = 1
	pass # Replace with function body.


func _on_Mao_body_exited(body):
	if body.get_groups().has("bola"):
		colisao = 0
	pass # Replace with function body.

























