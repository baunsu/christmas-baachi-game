extends Area2D

@export var speed = 750
var red_gift = preload("res://sprites/presents/red.png")
var green_gift = preload("res://sprites/presents/green.png")
var blue_gift = preload("res://sprites/presents/blue.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= transform.y * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Baachi"):
		body.queue_free()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
