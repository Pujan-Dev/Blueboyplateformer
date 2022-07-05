extends KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const UP = Vector2(0,-1)
const speed = 120 
var  motion = Vector2()

#gravity
var gravity= 20
var max_Gravity = 400

#Jump button
var JumpForce = 450

var facing_right= true

var acc = 30

func _physics_process(_delta):
	motion.x = clamp(motion.x,-speed,speed)
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
		
	motion.y += gravity
	if motion.y >max_Gravity:
		motion.y = max_Gravity
	if Input.is_action_pressed("A"):
		motion.x -= acc
		facing_right = false
		
	elif Input.is_action_pressed("D"):
		motion.x += acc
		facing_right = true
	else:
		motion.x = 0
		lerp(motion.x,0,0.2)
	
	# Move
	if motion.x >0 or motion.x <0 and is_on_floor():
		$Sprite.animation ="RUN"
	#Stand animation
	if  is_on_floor()  :
		if motion.x == 0:
			$Sprite.animation ="stand"
	else:
		pass
	#Jump Animation
	if motion.y < 0 and !is_on_floor():
		$Sprite.animation ="Jump"
	if motion.y>0 and !is_on_floor():
		$Sprite.animation ="FALL"
	#Jump button
	if is_on_floor() and Input.is_action_just_pressed("jump"):		
		$Jump.play()
		motion.y = -JumpForce
# warning-ignore:return_value_discarded
	move_and_slide(motion,UP)
