class_name Player
extends CharacterBody2D

@onready var m_player: CharacterBody2D = $player

const SPEED = 150.0
const JUMP_VELOCITY = -350.0


var flipy: bool = true

func _enter_tree() -> void:
	set_multiplayer_authority(int(str(name)))

func move(a):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * a

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		scale.x = -1
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	move(delta)
	
	
