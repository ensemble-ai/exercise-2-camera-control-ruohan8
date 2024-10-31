class_name PositionLockLerp
extends CameraControllerBase

@export var follow_speed:float = 48.0
@export var catchup_speed:float = 40.0
@export var leash_distance:float = 5.0

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	# leash check
	var distance:float = pow(pow((tpos.x - cpos.x),2) + pow((tpos.z - cpos.z),2),0.5)
	var dir = Vector3(tpos.x - cpos.x, 0, tpos.z - cpos.z)
	var unit_vector:Vector3 = dir.normalized()
	if (distance > leash_distance):
		global_position += unit_vector * (distance - leash_distance)
	
	# follow: if not moving move in direction of target at follow speed
	# else move in direction of target at catchup speed
	if not (target.velocity.length() == 0):
		global_position += unit_vector * follow_speed * delta
	else:
		global_position.x += (tpos.x - cpos.x) * (catchup_speed * delta)
		global_position.z += (tpos.z - cpos.z) * (catchup_speed * delta)
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
