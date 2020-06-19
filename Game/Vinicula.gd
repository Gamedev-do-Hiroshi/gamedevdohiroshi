extends Node2D

const GRAVIDADE = 30.0
const CENTRO = Vector2(640, 360)
var area = preload("res://Setor_vinicula.tscn")
var gravidade


var iden

func _ready():
	Physics2DServer.area_set_param(get_world_2d().get_space(),Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0,0))
	
	pass

func _physics_process(delta):
	
	for x in $Area.get_overlapping_bodies():
		
		if !x.get_groups().has("mapa"):
		
			gravidade = - GRAVIDADE * 1/( (CENTRO - x.position).length() )
			if x.get_groups().has("player"):
				x.vel_vinicola += gravidade * (CENTRO - x.position) * delta
			else:
				x.linear_velocity += gravidade * (CENTRO - x.position) * delta
	pass
