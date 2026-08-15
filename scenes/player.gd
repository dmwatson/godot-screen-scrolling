class_name Player
extends CharacterBody2D

@export var speed: float = 100.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	get_inputs()
	velocity = direction * speed
	move_and_slide()

func get_inputs() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
