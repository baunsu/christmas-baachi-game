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
	var baachi_spawn_location = $BaachiPath/BaachSpawnLocation
	baachi_spawn_location.progress_ratio = randf()
	
	var dir = baachi_spawn_location.rotation + PI / 2
	baachi.position = baachi_spawn_location.position
	
	dir += randf_range(-PI / 4, PI / 4)
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	baachi.linear_velocity = velocity.rotated(dir)
	
	add_child(baachi)


func _on_start_timer_timeout() -> void:
	$BaachiTimer.start()
