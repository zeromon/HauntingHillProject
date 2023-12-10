extends CharacterBody3D

#signal damage
@export var PLAYERSTATS = {
	"Health" : 100,
	"Mana" : 100,
	"Stamina" : 100,
	'WalkSpeed' : 4
}

@onready var health = PLAYERSTATS.Health
var healthmax = 100
@onready var mana = PLAYERSTATS.Mana
@onready var stamina = PLAYERSTATS.Stamina
@onready var walk_speed = PLAYERSTATS.WalkSpeed


const JUMP_VELOCITY = 4.5


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		pass
		#enemy.connect("damage", damage)

func _input(event):
	if InputEventMouseMotion:
		control_camera() #/ takes player mouse input for camera control
	
	
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		velocity.z = move_toward(velocity.z, 0, walk_speed)
	
	
	
	move_and_slide()
	
	
	pass


func control_camera():
	var mousePos = get_viewport().get_mouse_position()
	var camera = $PlayerOrigin/WorldCam
	var mouseCast = $PlayerOrigin/WorldCam/MouseCast
	var rayOrigin = camera.project_ray_origin(mousePos)
#	$PlayerOrigin.transform.basis.rotate_y(0.01)
	pass
	
#func damage(severity):
#	pass

func _process(delta):
	pass
