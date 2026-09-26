class_name ServingCounter
extends Node2D

signal soup_requested
signal soup_served(soup: Variant)

var _soup: Variant = null

@onready var plate: Polygon2D = %Plate
@onready var action_button: Button = %ActionButton


func _ready() -> void:
	_refresh_visuals()


func set_soup(soup: Variant) -> void:
	_soup = soup
	_refresh_visuals()


func has_soup() -> bool:
	return _soup != null


func _on_action_button_pressed() -> void:
	if _soup == null:
		soup_requested.emit()
		return

	var served_soup: Variant = _soup
	_soup = null
	_refresh_visuals()
	soup_served.emit(served_soup)


func _refresh_visuals() -> void:
	plate.visible = _soup != null
	action_button.text = "提供する" if _soup != null else "鍋から盛る"
