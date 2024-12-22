extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$BaachiTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPos.position)
	$StartTimer.start()

func _on_baachi_timer_timeout() -> void:
	var baachi = mob_scene.instantiate()
	var baachi_spawn_location
	var speed
	
	var color = randi_range(1,3)
	
	match color:
		1:
			baachi_spawn_location = $RedSpawn
			speed = -150
			baachi.get_node("AnimatedSprite2D").play("red")
		2:
			baachi_spawn_location = $GreenSpawn
			speed = 200
			baachi.get_node("AnimatedSprite2D").play("green")
		3:
			baachi_spawn_location = $BlueSpawn
			speed = -250
			baachi.get_node("AnimatedSprite2D").play("blue")
	
	print(baachi.get_node("AnimatedSprite2D").animation)
	baachi.position = baachi_spawn_location.position
	
	var velocity = Vector2(randf_range(150.0, 350.0), 0.0)
	baachi.linear_velocity = velocity.normalized() * speed
	
	add_child(baachi)


func _on_start_timer_timeout() -> void:
	$BaachiTimer.start()
