extends Area2D

@export var Bullet : PackedScene
@export var speed = 400
var screen_size
var shooting = false
var bullet

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
	
	if Input.is_action_just_pressed("shoot_red") and shooting == false:
		shoot("red")
	if Input.is_action_just_pressed("shoot_green") and shooting == false:
		shoot("green")
	if Input.is_action_just_pressed("shoot_blue") and shooting == false:
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
	shooting = true
	bullet = Bullet.instantiate()
	match color:
		"red":
			bullet.speed = 450
			bullet.get_node("Sprite2D").texture = bullet.red_gift
			bullet.color = color
		"green":
			bullet.speed = 600
			bullet.get_node("Sprite2D").texture = bullet.green_gift
			bullet.color = color
		"blue":
			bullet.speed = 750
			bullet.get_node("Sprite2D").texture = bullet.blue_gift
			bullet.color = color
	owner.add_child(bullet)
	bullet.transform = $gift_throw_pos.global_transform
	await get_tree().create_timer(0.10).timeout
	shooting = false
