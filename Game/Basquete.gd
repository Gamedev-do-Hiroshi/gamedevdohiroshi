extends Node2D

func _ready():
	var cena_Bola = preload("res://Bola.tscn")
	var ball = cena_Bola.instance()
	ball.position.x = 640
	ball.position.y = 200
	$Timer.connect("timeout", ball, "_on_Timer_timeout")
	add_child(ball)
	
	print("Comecou")
	pass

func _process(delta):
	#print($Bola.rotation)
	
	pass


func _on_Cesta1_body_exited(body):
	if body.position.y < $Cesta1.position.y:
		print("ponto")
	
	pass # Replace with function body.


func _on_Cesta1_body_entered(body):
	print(body)
	
	if body.position.x < 220 and body.position.y < 380:
		print("ponto1")
		$Timer.set_wait_time(3)
		$Timer.start()
		
	
	pass # Replace with function body.


func _on_Timer_timeout():
	var cena_Bola = preload("res://Bola.tscn")
	var ball = cena_Bola.instance()
	ball.position.x = 640
	ball.position.y = 200
	$Timer.connect("timeout", ball, "_on_Timer_timeout")
	add_child(ball)
	
	$Timer.set_wait_time(3)
	$Timer.stop()
	
	pass # Replace with function body.


func _on_Cesta2_body_entered(body):
	
	if body.position.x > 1050 and body.position.y < 380:
		print("ponto2")
		$Timer.set_wait_time(3)
		$Timer.start()
		
	pass # Replace with function body.
