extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum direction {
	UP,
	DOWN,
	UP_RIGHT,
	DOWN_RIGHT,
	UP_LEFT,
	DOWN_LEFT,
	LEFT,
	RIGHT,
	IDLE
}

var current_direction: direction = direction.IDLE

var KEY_UP = false
var KEY_DOWN = false
var KEY_RIGHT = false
var KEY_LEFT = false

func get_input():
	KEY_UP = Input.is_action_pressed("up")
	KEY_DOWN = Input.is_action_pressed("down")
	KEY_LEFT = Input.is_action_pressed("left")
	KEY_RIGHT = Input.is_action_pressed("right")

func set_direction():
	if KEY_UP:
		if KEY_RIGHT:
			current_direction = direction.UP_RIGHT
		elif KEY_LEFT:
			current_direction = direction.UP_LEFT
		else:
			current_direction = direction.UP
	elif KEY_DOWN:
		if KEY_RIGHT:
			current_direction = direction.DOWN_RIGHT
		elif KEY_LEFT:
			current_direction = direction.DOWN_LEFT
		else:
			current_direction = direction.DOWN
	elif KEY_LEFT:
		current_direction = direction.LEFT
	elif KEY_RIGHT:
		current_direction = direction.RIGHT   # <-- corregido
	else:
		current_direction = direction.IDLE

func cartesian_to_isometric(cartesian: Vector2) -> Vector2:
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y)) / 2

func move():
	match current_direction:
		direction.UP:
			velocity = cartesian_to_isometric(Vector2(0, -SPEED))
			$AnimatedSprite2D.play("up")
		direction.DOWN:
			velocity = cartesian_to_isometric(Vector2(0, SPEED))
			$AnimatedSprite2D.play("down")
		direction.LEFT:
			velocity = cartesian_to_isometric(Vector2(-SPEED, 0))
			$AnimatedSprite2D.play("left")
		direction.RIGHT:
			velocity = cartesian_to_isometric(Vector2(SPEED, 0))
			$AnimatedSprite2D.play("right")
		direction.UP_RIGHT:
			velocity = cartesian_to_isometric(Vector2(SPEED, -SPEED))
			$AnimatedSprite2D.play("up_right")
		direction.UP_LEFT:
			velocity = cartesian_to_isometric(Vector2(-SPEED, -SPEED))
			$AnimatedSprite2D.play("up_left")
		direction.DOWN_RIGHT:
			velocity = cartesian_to_isometric(Vector2(SPEED, SPEED))
			$AnimatedSprite2D.play("down_right")
		direction.DOWN_LEFT:
			velocity = cartesian_to_isometric(Vector2(-SPEED, SPEED))
			$AnimatedSprite2D.play("down_left")
		direction.IDLE:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.stop()
			# o $AnimatedSprite2D.play("idle") si tienes animación idle

	move_and_slide()

func _physics_process(delta: float) -> void:
	get_input()
	set_direction()
	move()
