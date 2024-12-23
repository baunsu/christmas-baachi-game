extends CanvasLayer

signal start_game
signal end_game
	
func update_time():
	$Time.text = str(ceil($TimeLimit.time_left))
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	
	$Message.text = "Merry Christmas"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$Start.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_pressed() -> void:
	$Start.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()

func _on_time_limit_timeout() -> void:
	end_game.emit()
