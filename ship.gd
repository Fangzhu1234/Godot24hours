extends Area2D

@export var ship_speed = 200
var screen_size = Vector2()
var ship_size = Vector2()
signal ship_fired(position)
signal ship_explosion(position)
var ship_velocity = Vector2.ZERO
var reloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	ship_size = $AnimatedSprite2D.get_sprite_frames().get_frame_texture("default", 0).get_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ship_velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * ship_speed
	position += ship_velocity * delta
	position.x = clamp(position.x, 0+ship_size.x/2, screen_size.x-ship_size.x/2)
	position.y = clamp(position.y, 0+ship_size.y/2, screen_size.y-ship_size.y/2)
	if Input.is_action_pressed("fire") and reloading == false:
		emit_signal("ship_fired", position)
		$Timer.start()
		reloading = true


func _on_timer_timeout():
	reloading = false


func _on_area_entered(area):
	if area.is_in_group("astroids"):
		emit_signal("ship_explosion", position)
		queue_free()
