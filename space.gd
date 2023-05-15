extends Node2D

var bullet_scene = preload("res://bullet.tscn")
var ship_scene = preload("res://ship.tscn")
var astroid_scene = preload("res://astroid.tscn")
var explosion_scene = preload("res://explosion.tscn")

var player
var spawn_position
var score = 0
var screen_size = Vector2()
@export var scroll_speed = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	player = ship_scene.instantiate()
	player.position = Vector2(20, 90)
	player.connect("ship_fired", _on_ship_fired)
	player.connect("ship_explosion", _on_ship_explosion)
	add_child(player)
	spawn_position = $Path2D/PathFollow2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Background.position.x <= -screen_size.x:
		$Background.position = Vector2(0, 0)
	else:
		$Background.position += Vector2(-scroll_speed * delta, 0)
	

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

func _on_explosion(object_position, object_score):
	var explosion = explosion_scene.instantiate()
	explosion.position = object_position
	add_child(explosion)
	score += object_score
	$HBoxContainer/ScoreLabel.text = "score: " + str(int(score)) 
	
func _on_ship_explosion(ship_position):
	var explosion = explosion_scene.instantiate()
	explosion.position = ship_position
	add_child(explosion)
	$GameoverLabel.show()
	$HBoxContainer/ScoreLabel.text = "score: 0"
	$RestartTimer.start()

func _on_restart_timer_timeout() -> void:
	print("restart game now")
	get_tree().change_scene_to_file("res://space.tscn")
