extends KinematicBody2D

var motion = Vector2()

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500

func _ready():
	pass

func _physics_process(delta):
	
	#print("Motion: ", motion.y)
	
	# Gravity
	motion.y += GRAVITY
	
	var friccion = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x -= ACCELERATION
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friccion = true
		
		
	#print("Is on floor: " + str(is_on_floor()))
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friccion == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 100:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		
		if friccion == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)