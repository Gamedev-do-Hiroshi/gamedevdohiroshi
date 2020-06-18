extends MarginContainer
onready var p1_lifenumber_label = $HBoxContainer/P1Bars/LifeBar/Count/Background/Number
onready var p1_energynumber_label = $HBoxContainer/P1Bars/EnergyBar/Count/Background/Number
onready var p1_life_bar = $HBoxContainer/P1Bars/LifeBar/Gauge
onready var p1_energy_bar = $HBoxContainer/P1Bars/EnergyBar/Gauge
onready var p2_lifenumber_label = $HBoxContainer/P2Bars/LifeBar/Count/Background/Number
onready var p2_life_bar = $HBoxContainer/P2Bars/LifeBar/Gauge
onready var p2_energynumber_label = $HBoxContainer/P2Bars/EnergyBar/Count/Background/Number
onready var p2_energy_bar = $HBoxContainer/P2Bars/EnergyBar/Gauge

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
#	 var player_max_health = $"../Characters/Player".max_health
	var player_max_health = 100
	p1_life_bar.max_value = player_max_health
	p2_life_bar.max_value = player_max_health
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
