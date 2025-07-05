extends Area2D

@export var speed = 400
var screen_size #see the "clamp" (used to not let the caracter leave the screen)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	#this is pretty simple, i dont like, but whatever for now
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1 
	
	#this here is pretty intersting, this ends with the diagonal faster movement, how?
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	
	#to not let the caracter go out of the screen
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	pass
