extends Area2D

@export var Bullet : PackedScene
@export var speed = 400
var screen_size

signal shoot_red
signal shoot_green
signal shoot_blue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if Input.is_action_just_pressed("shoot_red"):
		shoot("red")
	if Input.is_action_just_pressed("shoot_green"):
		shoot("green")
	if Input.is_action_just_pressed("shoot_blue"):
		shoot("blue")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func shoot(color):
	var bullet = Bullet.instantiate()
	match color:
		"red":
			bullet.speed = 450
			bullet.get_node("Sprite2D").texture = bullet.red_gift
		"green":
			bullet.speed = 600
			bullet.get_node("Sprite2D").texture = bullet.green_gift
		"blue":
			bullet.speed = 750
			bullet.get_node("Sprite2D").texture = bullet.blue_gift
	owner.add_child(bullet)
	bullet.transform = $gift_throw_pos.global_transform
