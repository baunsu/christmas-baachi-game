extends Node

@export var mob_scene: PackedScene
@export var essie_totem: PackedScene
@export var game_time: float
var baachi

func _ready() -> void:
    $Player.hide()
    $Player.shooting = true
    
func _process(delta: float) -> void:
    $HUD.update_time()
    $HUD.update_score(Global.score)
    
func new_game():
    Global.score = 0
    $Player.start($StartPos.position)
    $StartTimer.start()
    $HUD.update_score(Global.score)
    $HUD.show_message("Get ready")
    $Player.show()
    $TotemSpawn.start()

func game_over():
    $Player.shooting = true
    $GameOverSound.play()
    $BaachiTimer.stop()
    $HUD/TimeLimit.stop()
    $TotemSpawn.stop()
    $HUD.show_game_over()
    $Player.hide()
        
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
    
func _on_totem_spawn_timeout() -> void:
    var totem = essie_totem.instantiate()
    var totem_spawn
    var speed = 350
    
    var color = randi_range(1,3)
    
    match color:
        1:
            totem_spawn = $RedSpawn
            speed *= -1
        2:
            totem_spawn = $GreenSpawn
        3:
            totem_spawn = $BlueSpawn
            speed *= -1
    
    totem.position = totem_spawn.position
    var velocity = Vector2(350.0, 0.0)
    totem.linear_velocity = velocity.normalized() * speed
    
    add_child(totem)

func _on_start_timer_timeout() -> void:
    $BaachiTimer.start()
    $HUD/TimeLimit.set_wait_time(game_time)
    $HUD/TimeLimit.start()
    $Player.shooting = false
