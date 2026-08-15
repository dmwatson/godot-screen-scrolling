class_name FollowingCamera
extends Camera2D

# The Area2D that detects when the player is leaving the screen
@onready var detector: Area2D = $Area2D

## Duration of the screen scroll
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var scroll_time: float = 1.0

# Size of the viewport
var screen_size: Vector2

# The target coordinates to move the camera offset to
var move_target: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	get_viewport()
	#print(screen_size)
	detector.body_exited.connect(on_player_leave)
	detector.get_child(0).shape.size = screen_size
	detector.get_child(0).position = screen_size / 2.0

func on_player_leave(body: Node2D) -> void:

	if body is Player:
		move_target = offset
		
		# Get their velocity
		var player = body as Player
		
		var dir: Vector2 = player.velocity.normalized()

		if dir == Vector2.DOWN:
			move_target.y += screen_size.y
		if dir == Vector2.UP:
			move_target.y -= screen_size.y
		if dir == Vector2.LEFT:
			move_target.x -= screen_size.x
		if dir == Vector2.RIGHT:
			move_target.x += screen_size.x
		
		# Disable movement while scrolling
		player.set_physics_process(false)
		
		# Turn off collision detection for now to avoid any potential false positives
		detector.set_collision_mask_value(2, false)
		await get_tree().process_frame
		var tween: Tween = get_tree().create_tween() 
		tween.set_parallel(true)
		tween.tween_property(self, "offset", move_target, scroll_time)
		#tween.tween_property(detector, "global_position", move_target, scroll_time)
		await tween.finished
		detector.global_position = move_target
		detector.set_collision_mask_value(2, true)
		player.set_physics_process(true)
