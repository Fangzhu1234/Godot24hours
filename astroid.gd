extends Area2D

@export var astroid_speed = 250
signal astroid_explosion(position, score)

# Called when the node enters the scene tree for the first time.
func _ready():
	astroid_speed = randf_range(100, 300)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(-astroid_speed, 0) * delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("bullets") or area.is_in_group("ship"):
		emit_signal("astroid_explosion", position, astroid_speed)
		queue_free()
