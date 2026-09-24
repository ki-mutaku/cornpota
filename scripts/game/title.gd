extends Control

@onready var game_start_button: Button = %GameStartButton
@onready var exit_button: Button = %ExitButton
@onready var status_label: Label = %StatusLabel


func _ready() -> void:
	game_start_button.pressed.connect(_on_game_start_pressed)
	exit_button.pressed.connect(_on_exit_pressed)


func _on_game_start_pressed() -> void:
	status_label.text = "ゲーム本編は準備中です"


func _on_exit_pressed() -> void:
	if OS.has_feature("web"):
		status_label.text = "Web版ではブラウザのタブを閉じて終了してください"
		return

	get_tree().quit()
