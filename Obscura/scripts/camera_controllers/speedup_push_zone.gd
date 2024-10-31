class_name SpeedUpPushZone
extends CameraControllerBase

@export var push_ratio := 0.5
@export var pushbox_top_left := Vector2(-10,7)
@export var pushbox_bottom_right := Vector2(10,-7)
@export var speedup_zone_top_left := Vector2(-5,2)
@export var speedup_zone_bottom_right := Vector2(5,-2)


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

	# outer pushbox
	var pushbox_width:float = pushbox_bottom_right.x - pushbox_top_left.x
	var pushbox_height:float = pushbox_top_left.y - pushbox_bottom_right.y
	# inner speedup zone
	var inner_width:float = speedup_zone_bottom_right.x - speedup_zone_top_left.x
	var inner_height:float = speedup_zone_top_left.y - speedup_zone_bottom_right.y
	# left outer edge check
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - pushbox_width / 2.0)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	else:
		# left inner edge check
		var diff_between_left_inner = (tpos.x - target.WIDTH / 2.0) - (cpos.x - inner_width / 2.0)
		if diff_between_left_inner < 0 && target.velocity.x < 0:
			global_position.x += target.velocity.x * push_ratio * delta
	# right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_width / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	else:
		# right inner edge check
		var diff_between_right_inner = (tpos.x + target.WIDTH / 2.0) - (cpos.x + inner_width / 2.0)
		if diff_between_right_inner > 0 && target.velocity.x > 0:
			global_position.x += target.velocity.x * push_ratio * delta
	# top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_height / 2.0)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	else:
		# top inner edge check
		var diff_between_top_inner = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - inner_height / 2.0)
		if diff_between_top_inner < 0 && target.velocity.z < 0:
			global_position.z += target.velocity.z * push_ratio * delta
	# bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_height / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
	else:
		# bottom inner edge check
		var diff_between_bottom_inner = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + inner_height / 2.0)
		if diff_between_bottom_inner > 0 && target.velocity.z > 0:
			global_position.z += target.velocity.z * push_ratio * delta

	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = pushbox_top_left.x
	var right:float = pushbox_bottom_right.x
	var top:float = pushbox_top_left.y
	var bottom:float = pushbox_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# draw inner box
	# for debugging
	var mesh_instance_inner := MeshInstance3D.new()
	var immediate_mesh_inner := ImmediateMesh.new()
	var material_inner := ORMMaterial3D.new()
	
	mesh_instance_inner.mesh = immediate_mesh_inner
	mesh_instance_inner.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left_inner:float = speedup_zone_top_left.x
	var right_inner:float = speedup_zone_bottom_right.x
	var top_inner:float = speedup_zone_top_left.y
	var bottom_inner:float = speedup_zone_bottom_right.y
	
	immediate_mesh_inner.surface_begin(Mesh.PRIMITIVE_LINES, material_inner)
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, top_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, bottom_inner))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, bottom_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, bottom_inner))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, bottom_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, top_inner))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(left_inner, 0, top_inner))
	immediate_mesh_inner.surface_add_vertex(Vector3(right_inner, 0, top_inner))
	immediate_mesh_inner.surface_end()

	material_inner.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material_inner.albedo_color = Color.BLACK
	
	add_child(mesh_instance_inner)
	mesh_instance_inner.global_transform = Transform3D.IDENTITY
	mesh_instance_inner.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	mesh_instance_inner.queue_free()
