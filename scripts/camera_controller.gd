extends SpringArm3D

#rotation camera haut/bas
@export var min_limit_x: float
@export var max_limit_x: float

@export var horizontal_acceleration := 2.0
@export var vertical_acceleration := 1.0
@export var mouse_acceleration := 0.005

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#print(event.relative)
		#rotation.y += event.relative.x *0.005
		rotate_from_vector(event.relative * mouse_acceleration)

func rotate_from_vector(v: Vector2):
	if v.length() == 0:return
	#horizontal rotation
	rotation.y -= v.x
	#vertical rotation
	rotation.x -= v.y
	#limit the rotation
	rotation.x = clamp(rotation.x, min_limit_x, max_limit_x)
	#invert camera movement
	#rotation.y -= v.x
