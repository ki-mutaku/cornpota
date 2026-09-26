class_name CookingLadle
extends Node2D

signal drag_started
signal dragged(global_pointer_position: Vector2, distance: float)
signal drag_ended

@export var movement_bounds: Rect2 = Rect2(24.0, 24.0, 1232.0, 672.0)

var _dragging: bool = false
var _touch_index: int = -1
var _grab_offset: Vector2 = Vector2.ZERO
var _last_position: Vector2 = Vector2.ZERO
var _home_global_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	_home_global_position = global_position


func _input(event: InputEvent) -> void:
	if not _dragging:
		return

	if event is InputEventScreenDrag and event.index == _touch_index:
		_move_to(event.position)
	elif event is InputEventScreenTouch and event.index == _touch_index and not event.pressed:
		_end_drag()
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_move_to(event.position)
	elif (
		event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and not event.pressed
	):
		_end_drag()


func _on_handle_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_begin_drag(event.position, event.index)
		viewport.set_input_as_handled()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_begin_drag(event.position, -1)
		viewport.set_input_as_handled()


func _begin_drag(pointer_position: Vector2, touch_index: int) -> void:
	_dragging = true
	_touch_index = touch_index
	_grab_offset = global_position - pointer_position
	_last_position = global_position
	z_index = 20
	drag_started.emit()


func _move_to(pointer_position: Vector2) -> void:
	var desired: Vector2 = pointer_position + _grab_offset
	desired.x = clampf(desired.x, movement_bounds.position.x, movement_bounds.end.x)
	desired.y = clampf(desired.y, movement_bounds.position.y, movement_bounds.end.y)
	global_position = desired
	var distance: float = global_position.distance_to(_last_position)
	_last_position = global_position
	dragged.emit(pointer_position, distance)


func _end_drag() -> void:
	_dragging = false
	_touch_index = -1
	z_index = 5
	drag_ended.emit()


func reset_state() -> void:
	_dragging = false
	_touch_index = -1
	global_position = _home_global_position
	z_index = 5
