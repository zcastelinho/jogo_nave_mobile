extends CharacterBody2D


var speed = 200
var vel = Vector2()
var combustivel = 100

##momento 2
var balap = preload("res://Laser.tscn")
var lado = 1
##momento 2

signal morreu

func _ready():
	$AnimatedSprite2D.play()
	
func _physics_process(delta):
	vel.x = 0
	vel.y = 0
	
	if Input.is_action_pressed("ui_up"):
		vel.y -= speed
	if Input.is_action_pressed("ui_down"):
		vel.y += speed
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
		lado = 1
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed
		lado = -1
	
	##momento 2
	if Input.is_action_just_pressed("atira"):
		$atira.play()
		var novabala = balap.instantiate()
		novabala.position.x = position.x+4
		novabala.position.y = position.y+4
		novabala.z_index = -1
		novabala.setlado(lado)
		get_tree().current_scene.add_child(novabala)
	##momento 2	
			
		
	set_velocity(vel)
	set_up_direction(Vector2.UP)
	move_and_slide()
	vel = velocity
	
	if vel.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif vel.x > 0:
		$AnimatedSprite2D.flip_h = false
		
		
func morre():
	emit_signal("morreu")
	$AnimatedSprite2D.stop()
	
func tomadano():
	combustivel -= 10
	if combustivel <= 0:
		morre()
