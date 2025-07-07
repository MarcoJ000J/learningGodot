extends CanvasLayer

#to notify main o fthe start of the game
signal start_game

signal game_over_done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#to show a message befire the game starts
func show_message(text):
	$"Message(Label)".text = text
	$"Message(Label)".show()
	$"MessageTimer(Timer)".start()

#to show thw end game
func show_game_over():
	show_message("Game Over! :(")
	#waits the timer of the showMessage function
	await $"MessageTimer(Timer)".timeout
	
	game_over_done.emit()
	
	#interesting way to use less objects, hmm
	$"Message(Label)".text = "Dodge the Creeps!"
	$"Message(Label)".show()
	#wait one second to show the mwnu again
	await  get_tree().create_timer(1.0).timeout
	$"StartButton(Button)".show()

func update_score(score):
	$"ScoreLabel(Label)".text = str(score)


func _on_start_button_button_pressed() -> void:
	$"StartButton(Button)".hide()
	start_game.emit()


func _on_message_timer_timer_timeout() -> void:
	$"Message(Label)".hide()
