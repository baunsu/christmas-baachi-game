extends Node

@export var mob_scene: PackedScene
var baachi

func _ready() -> void:
    $Player.hide()
    
func _process(delta: float) -> void:
    $HUD.update_time()
    $HUD.update_score(Global.score)
    
func game_over():
    $BaachiTimer.stop()
    $HUD/TimeLimit.stop()
    $HUD.show_game_over()
    
func new_game():
    Global.score = 0
    $Player.start($StartPos.position)
    $StartTimer.start()
    $HUD.update_score(Global.score)
    $HUD.show_message("Get ready")
    
func add_score(points):
    $HUD.update_score(points)
    $HUD/TimeLimit.get_wait_time()
    
func _on_baachi_timer_timeout() -> void:
    baachi = mob_scene.instantiate()
    var baachi_spawn_location
    var speed
    
    var color = randi_range(1,3)
    
    match color:
        1:
            baachi_spawn_location = $RedSpawn
            speed = -150
            baachi.get_node("AnimatedSprite2D").play("red")
            baachi.color = "red"
        2:
            baachi_spawn_location = $GreenSpawn
            speed = 200
            baachi.get_node("AnimatedSprite2D").play("green")
            baachi.color = "green"
        3:
            baachi_spawn_location = $BlueSpawn
            speed = -250
            baachi.get_node("AnimatedSprite2D").play("blue")
            baachi.color = "blue"
    
    baachi.position = baachi_spawn_location.position
    
    var velocity = Vector2(randf_range(150.0, 350.0), 0.0)
    baachi.linear_velocity = velocity.normalized() * speed
    
    add_child(baachi)

func _on_start_timer_timeout() -> void:
    $BaachiTimer.start()
    $HUD/TimeLimit.start()
