extends CharacterBody2D

@export var speed := 100
@export var bullet_scene: PackedScene
@export var timer: Timer
@export var bullet_speed := 300 
@export var audio_player: AudioStreamPlayer

var _last_direction: Vector2 = Vector2.LEFT

func _ready():
	timer.timeout.connect(_on_timeout)


func _process(delta):
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed
	if direction != Vector2.ZERO:
		_last_direction = direction
	move_and_slide()


func _on_timeout():
	var bullet := bullet_scene.instantiate() as Bullet
	get_parent().add_child(bullet)
	bullet.global_position = self.global_position
	bullet.set_velocity(_last_direction * bullet_speed)
	audio_player.play()
