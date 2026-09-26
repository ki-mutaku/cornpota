class_name CookingMixer
extends Node2D

signal contents_changed(contents: Array[Dictionary])
signal operation_started
signal operation_stopped

var contents: Array[Dictionary] = []
var is_operating: bool = false

@onready var blade: Polygon2D = %Blade
@onready var state_label: Label = %StateLabel


func _process(delta: float) -> void:
	if is_operating:
		blade.rotation += delta * 12.0


func add_ingredient(ingredient: Variant, amount: float = 1.0) -> void:
	if ingredient == null or amount <= 0.0:
		return
	contents.append({"data": ingredient, "amount": amount})
	contents_changed.emit(contents.duplicate(true))
	_refresh_label()


func take_contents() -> Array[Dictionary]:
	var result: Array[Dictionary] = contents.duplicate(true)
	contents.clear()
	contents_changed.emit([])
	_refresh_label()
	return result


func reset_state() -> void:
	is_operating = false
	contents.clear()
	contents_changed.emit([])
	_refresh_label()


func _on_ingredient_drop_area_item_received(
	payload: Variant,
	_source: DirectDraggableItem,
) -> void:
	add_ingredient(payload)


func _on_operation_button_button_down() -> void:
	if contents.is_empty():
		return
	is_operating = true
	operation_started.emit()
	_refresh_label()


func _on_operation_button_button_up() -> void:
	if not is_operating:
		return
	is_operating = false
	operation_stopped.emit()
	_refresh_label()


func _refresh_label() -> void:
	if is_operating:
		state_label.text = "作動中"
	else:
		state_label.text = "中身 %d" % contents.size()
