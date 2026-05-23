extends CharacterBody2D

@export var speed := 100


func _process(delta):
  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
  velocity = direction * speed
  move_and_slide()