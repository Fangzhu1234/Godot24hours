extends Node2D

var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween().set_parallel()
	tween.tween_property($Sprite2D, "modulate", Color8(255,0,0,0), 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "scale", Vector2(1.5,1.5), 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
