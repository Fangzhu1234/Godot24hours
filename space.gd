extends Node2D

var bullet_scene = preload("res://bullet.tscn")
var ship_scene = preload("res://ship.tscn")
var astroid_scene = preload("res://astroid.tscn")
var explosion_scene = preload("res://explosion.tscn")

var player
var spawn_position

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player = ship_scene.instantiate()
	player.position = Vector2(20, 90)
	player.connect("ship_fired", _on_ship_fired)
	player.connect("ship_explosion", _on_explosion)
	add_child(player)
	spawn_position = $Path2D/PathFollow2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_ship_fired(fire_position):
	var bullet = bullet_scene.instantiate()
	bullet.position = fire_position
	add_child(bullet)
	


func _on_spawn_timer_timeout():
	spawn_position.progress_ratio = randf()
	var astroid = astroid_scene.instantiate()
	astroid.position = spawn_position.position
	astroid.connect("astroid_explosion", _on_explosion)
	add_child(astroid)
	$SpawnTimer.wait_time = randf_range(0.5, 3)

func _on_explosion(object_position):
	var explosion = explosion_scene.instantiate()
	explosion.position = object_position
	add_child(explosion)
