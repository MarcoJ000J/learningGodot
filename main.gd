extends Node

@export var mob_scene : PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Music(AudioStreamPlayer2D)".play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#stop the timer
func game_over() -> void:
	$"Score(Timer)".stop()
	$"MobTimer(Timer)".stop()
	
	$"Deathsound(AudioStreamPlayer2D)".play()
	
	$"HUD(CanvasLayer)".show_game_over()

#starts the start timer, the player, and the score
func new_game():
	score = 0
	$"Player(Area2D)".start($"StartPosition(Marker2D)".position)
	$"Start(Timer)".start()
	
	$"HUD(CanvasLayer)".update_score(score)
	$"HUD(CanvasLayer)".show_message("Get Ready!")

#satarts eh other timers when starts
func _on_start_timer_timeout() -> void:
	$"MobTimer(Timer)".start()
	$"Score(Timer)".start()

#keep adding to the score
func _on_score_timer_timeout() -> void:
	score += 1
	$"HUD(CanvasLayer)".update_score(score)


func _on_mob_timer_timer_timeout() -> void:
	#create a instance of the mob XD
	var mob = mob_scene.instantiate()
	
	#get a random point in the path to serve as the mob spawn poit
	var mob_spawn_location = $"MobPath(Path2D)/MobSpawnPoint(PathFollow2D)"
	mob_spawn_location.progress_ratio = randf()
	
	# set the mob position to the random position previosly choosed (is this right?)
	mob.position = mob_spawn_location.position
	
	#nah what?
	var direction = mob_spawn_location.rotation + PI / 2
	
	#swifts a litte the direction
	direction += randf_range(-PI /4, PI /4)
	mob.rotation = direction
	
	#choose velocity to the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func kill_mobs():
	get_tree().call_group("mobs", "queue_free")
