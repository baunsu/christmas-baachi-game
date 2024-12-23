extends RigidBody2D

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	
func _process(delta: float) -> void:
	$Sprite2D.rotation_degrees += 3 

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	hide()
	$AudioStreamPlayer2D.stop()
	$CollisionShape2D.set_deferred("disabled", true)
