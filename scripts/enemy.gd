extends RigidBody2D

var color

func _ready() -> void:
	$DeathSound.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body: Node) -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
