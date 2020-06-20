extends KinematicBody2D

export var player = 1

enum PODERES {VERMELHO, LARANJA, AZUL, GELO, AMARELO, ROXO, VERDE, ESPINHO}

export(PODERES) var poder = PODERES.VERMELHO

const MAX_SPEED = 400

const UP = Vector2(0, -1)
var SPEED = MAX_SPEED
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
const MAX_VEL_KNOCK_BACK = 200
const MAX_DURACAO_KNOCK_BACK = 0.2
var VEL_KNOCK_BACK = 200
var DURACAO_KNOCK_BACK = 0.2
var knock_back
var tempo_knock_back

var vel_colisao = Vector2()
var colisao = 0
var bola
var normal = Vector2()

var cena_poder
var novo_poder

var ocupado = 0

const DURACAO_GELO = 2.0
const VEL_GELO = 20
var gelou = 0
var tempo_gelo = 0.0
var vel_gelo
var gelo

const DURACAO_STUN = 2.0
var tempo_stun = 0.0
var stunado = 0

var vel_vinicola


var lento = 0

# --------------------------------------> FUNÇÃO CHAMADA QUANDO CARREGA O NÓ <-----------------------------------------
func _ready():
	if self.get_parent().get_groups().has("Floresta"):
		VEL_KNOCK_BACK = 2*MAX_VEL_KNOCK_BACK
		DURACAO_KNOCK_BACK = 2*DURACAO_KNOCK_BACK
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
	ocupado = 0
	gelou = 0
	stunado = 0
	tempo_stun = 0.0
	vel_vinicola = Vector2()
	
# --------------------------------------> FUNÇÃO CHAMADA A CADA FRAME <-----------------------------------------
func _process(delta):
	
	if vida <= 0:
		$Sprite.play("Dead")
	
	mana += TAXA_MANA * delta
	
	if mana > 100:
		mana = 100
	
	
	pass

# ---------------------------------------------------> FÍSICA <---------------------------------------------------------
func _physics_process(delta):
	for x in $Corpo.get_overlapping_areas():
		if x.get_groups().has("Area_espinhos"):
			lento = 1
			
	if lento:
		SPEED = MAX_SPEED/3
	else:
		SPEED = MAX_SPEED
		
	if !self.get_parent().get_groups().has("vinicola"):
		motion.y += GRAVITY
	
		if vida <= 0:
			$Sprite.play("Dead")
			return
	else:
		#motion = Vector2()
		for x in $Corpo.get_overlapping_bodies():
			#print("OLHA: ", x)
			if x.get_parent().get_groups().has("plataforma"):
				#vel_vinicola -= (position - x.position).normalized().cross(vel_vinicola) * (position - x.position).normalized().rotated(PI/2)
				vel_vinicola = Vector2()
				#print(vel_vinicola)
				self.rotation = x.get_node("Colisao").rotation
		position += vel_vinicola * delta
	
	
	if knock_back == 0 and stunado == 0: 
		socar(delta)
		if ocupado == 0:
			if !self.get_parent().get_groups().has("vinicola"):
				control(delta)
			else:
				control_vinicola(delta)
	elif knock_back != 0:
		empurrao(delta)
	
	if stunado:
		stun(delta)
	
	if colisao:
		motion = vel_colisao
	if gelou:
		geleira(delta)
	
	
	#print(motion)
	motion = move_and_slide(motion, UP)
	
	if gelou:
		motion.x = vel_gelo
		
	lento = 0
	
	pass

# -------------------------------------------------------> SOCO <------------------------------------------------------
func punch():
	if soco == 0:
		soco = 1
		tempo_soco = 0.0
		vel_soco = sentido * VEL_SOCO
		$Sprite.play("Punch")
		var sound = AudioStreamPlayer2D.new();
		self.add_child(sound);
		sound.stream = load("res://sounds/Woosh-Mark_DiAngelo-4778593.wav");
		sound.set_volume_db(-5);
		sound.play();
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
	if vida <= 0:
		$Sprite.play("Dead")
		return
	
	#print(lento)
	
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

func control_vinicola(delta):
	if vida <= 0:
		$Sprite.play("Dead")
		return
	
	#print(lento)
	
	if player == 1:
		if Input.is_action_pressed("ui_right"):
			motion += SPEED * Vector2(1, 0).rotated(self.rotation) * delta
			sentido = 1
			$Sprite.flip_h = true
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		elif Input.is_action_pressed("ui_left"):
			motion += -SPEED * Vector2(1, 0).rotated(self.rotation) * delta
			sentido = -1
			$Sprite.flip_h = false
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		else:
			#motion.x = 0
			if soco == 0:
				$Sprite.play("Idle")
		
		if Input.is_action_just_pressed("ui_up"):
			print("PRESSIONADO")
			for x in $Corpo.get_overlapping_bodies():
				print("OLHA: ", x)
				if x.get_parent().get_groups().has("plataforma"):
					motion += JUMP_HEIGHT * Vector2(0, 1).rotated(self.rotation)
					print("PULA")
					return
		#else:
			#$Sprite.play("Jump")
			
		if Input.is_key_pressed(KEY_ENTER):
			punch()
		
		if Input.is_key_pressed(KEY_L):
			ativar_poder()
		

		pass
		
	elif player == 2:
		
		if Input.is_key_pressed(KEY_D):
			motion += SPEED * Vector2(1, 0).rotated(self.rotation) * delta
			sentido = 1
			$Sprite.flip_h = true
			if soco == 0:
				$Sprite.play("Run")
			else:
				#animação de Run + punch
				pass
		elif Input.is_key_pressed(KEY_A):
			motion += - SPEED * Vector2(1, 0).rotated(self.rotation) * delta
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
		
		if Input.is_key_pressed(KEY_W):
			print("PRESSIONADO")
			for x in $Corpo.get_overlapping_bodies():
				print("OLHA: ", x)
				if x.get_parent().get_groups().has("plataforma"):
					motion += JUMP_HEIGHT * Vector2(0, 1).rotated(self.rotation)
					print("PULA")
					return
				
		#else:
			#$Sprite.play("Jump")
			
		if Input.is_key_pressed(KEY_SPACE):
			punch()
	
		if Input.is_key_pressed(KEY_Q):
			ativar_poder()

	pass

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
		self.get_parent().add_child(novo_poder)
	elif poder == 2:
		novo_poder.position = position +  Vector2(sentido*50, -10)
		self.get_parent().add_child(novo_poder)
	elif poder == PODERES.AMARELO:
		novo_poder.position = Vector2(sentido*10, 6)
		$Sprite.animation = "Laser"
		ocupado = 1
		self.add_child(novo_poder)
	elif poder == PODERES.VERDE:
		novo_poder.position = position +  Vector2(sentido*50, -10)
		self.get_parent().add_child(novo_poder)
	pass

func gelado(direcao):
	
	print("direção: " + String(direcao))
	
	cena_poder = load("res://Poderes.tscn")
	novo_poder = cena_poder.instance()
	novo_poder.poder = 3
	ocupado = 1
	gelou = 1
	tempo_gelo = 0.0
	vel_gelo = motion.x + direcao*VEL_GELO
	#novo_poder.sentido = sentido
	#novo_poder.velocidade = motion
	#novo_poder.position = position
	
	self.add_child(novo_poder)
	
	gelo = novo_poder
	
	
	pass

func geleira(delta):
	tempo_gelo += delta
	if tempo_gelo < DURACAO_GELO:
		pass
	else:
		gelou = 0
		tempo_gelo = 0.0
		motion.x = 0
		ocupado = 0
		gelo.free()
	pass

func stun(delta):
	tempo_stun += delta
	if tempo_stun >= DURACAO_STUN:
		stunado = 0
		tempo_stun = 0.0
	
	pass

# ------------------------------------------------------> SINAIS <------------------------------------------------------

func _on_Mao_area_entered(area):
	print(String(player) + " " + String(area.get_groups()) + " soco = " + String(soco)) 
	
	if(soco == 0):
		pass
	
	if ((area.get_groups().has("mao") or area.get_groups().has("corpo"))  and area.get_parent() != self):
		print("SOQUEI")
		area.get_parent().vida -= 10
		var sound = AudioStreamPlayer2D.new();
		self.add_child(sound);
		sound.stream = load("res://sounds/Realistic_Punch-Mark_DiAngelo-1609462330.wav");
		sound.set_volume_db(-5);
		sound.play();
		
		if area.get_parent().vida <= 0:
			area.get_parent().get_node("Sprite").flip_h = !($Sprite.flip_h)
			pass
			
		area.get_parent().socado(sentido)
		
		
	
	
	pass


func _on_Corpo_body_entered(body):
	print(body)
	if body.get_groups().has("bola"):
		normal = (position - body.position).normalized()
		vel_colisao = normal * 200	
		body.apply_central_impulse(200*normal * motion.dot(normal))
		#print(200*normal * motion.dot(normal))
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
		#print(200*normal * (motion + Vector2(vel_soco, 0)).dot(normal))
		bola = body
		colisao = 1
	pass # Replace with function body.


func _on_Mao_body_exited(body):
	if body.get_groups().has("bola"):
		colisao = 0
	pass # Replace with function body.

























