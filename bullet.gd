class_name Bullet
extends Area2D

@export var visibility_notifier: VisibleOnScreenNotifier2D
@export var audio_stream: AudioStream

var velocity: Vector2


func _ready():
	visibility_notifier.screen_exited.connect(func():
		queue_free()
	)
	area_entered.connect(_on_area_entered)


func set_velocity(value: Vector2):
	velocity = value


func _process(delta):
	translate(velocity * delta)


func _on_area_entered(area: Area2D):
	if area.get_node(Destroyable.COMPONENT_NAME):
		var audio_player := AudioStreamPlayer.new()
		audio_player.stream = audio_stream
		get_parent().add_child(audio_player)
		audio_player.play()
		audio_player.finished.connect(func():
			audio_player.queue_free()
		)
		queue_free()
