extends KinematicBody

var direction = Vector3()
var speed = 400
var velocity = Vector3()

var freeMouse = true

onready var playerControl = $PlayerControl
onready var raycast = $PlayerControl/RayCast
onready var flashlight = $PlayerControl/Flashlight

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


func moveDirection(delta):
	direction = Vector3()
	
	if Input.get_action_strength("ui_up"):
		direction -= transform.basis.z
			
	if Input.get_action_strength("ui_down"):
		direction += transform.basis.z
		
	if Input.get_action_strength("ui_left"):
		direction -= transform.basis.x
		
	if Input.get_action_strength("ui_right"):
		direction += transform.basis.x
	
	direction = direction.normalized()
	direction *= speed
	
	velocity = move_and_slide(Vector3(direction.x * delta, velocity.y, direction.z * delta), Vector3.UP)

func interact():
	var result = raycast.get_collider()
	if result:
		print(result.is_in_group("battery"))
		if Input.is_action_just_pressed("ui_use"):
			result.get_parent().queue_free()
			flashlight.recharge()


func _physics_process(delta):
	moveDirection(delta)
	interact()
	
func _input(event):
	
	if event.is_action_pressed("ui_accept") and freeMouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		freeMouse = false
	elif event.is_action_pressed("ui_accept") and not freeMouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		freeMouse = true
		
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * 0.1))
		playerControl.rotate_x(deg2rad(-event.relative.y * 0.1))
		playerControl.rotation_degrees.x = clamp(playerControl.rotation_degrees.x, -50, 60)
