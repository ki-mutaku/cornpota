class_name DirectDraggableItem
extends Area2D

signal drag_started(item: DirectDraggableItem)
signal drag_moved(item: DirectDraggableItem, global_pointer_position: Vector2)
signal drag_finished(item: DirectDraggableItem, accepted: bool)

enum AcceptedBehavior {
	STAY,
	RETURN_HOME,
	HIDE,
}

@export var drag_tag: StringName = &"ingredient"
@export var payload: Resource
@export var movement_bounds: Rect2 = Rect2(0.0, 0.0, 1280.0, 720.0)
@export var return_on_rejected: bool = true
@export var accepted_behavior: AcceptedBehavior = AcceptedBehavior.RETURN_HOME

var _dragging: bool = false
var _touch_index: int = -1
var _grab_offset: Vector2 = Vector2.ZERO
var _home_global_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	_home_global_position = global_position
	input_event.connect(_on_input_event)


func _input(event: InputEvent) -> void:
	if not _dragging:
		return

	if event is InputEventScreenDrag and event.index == _touch_index:
		_move_to(event.position)
	elif event is InputEventScreenTouch and event.index == _touch_index and not event.pressed:
		_finish_drag(event.position)
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_move_to(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_finish_drag(event.position)


func get_interaction_payload() -> Variant:
	return payload if payload != null else self


func reset_to_home() -> void:
	global_position = _home_global_position
	visible = true


func _on_input_event(viewport: Viewport, event: InputEvent, _shape_index: int) -> void:
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
	z_index = 100
	drag_started.emit(self)


func _move_to(pointer_position: Vector2) -> void:
	var desired: Vector2 = pointer_position + _grab_offset
	desired.x = clampf(desired.x, movement_bounds.position.x, movement_bounds.end.x)
	desired.y = clampf(desired.y, movement_bounds.position.y, movement_bounds.end.y)
	global_position = desired
	drag_moved.emit(self, pointer_position)


func _finish_drag(pointer_position: Vector2) -> void:
	_dragging = false
	_touch_index = -1
	z_index = 0

	var accepted: bool = false
	var target: DirectDropTarget = _find_drop_target(pointer_position)
	if target != null:
		accepted = target.try_receive(self)

	if accepted:
		_apply_accepted_behavior()
	elif return_on_rejected:
		reset_to_home()

	drag_finished.emit(self, accepted)


func _find_drop_target(point: Vector2) -> DirectDropTarget:
	var query: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query.position = point
	query.collide_with_areas = true
	query.collide_with_bodies = false

	var hits: Array[Dictionary] = get_world_2d().direct_space_state.intersect_point(query, 32)
	for hit: Dictionary in hits:
		var collider: Variant = hit.get("collider")
		if collider is DirectDropTarget and collider.accepts(self):
			return collider
	return null


func _apply_accepted_behavior() -> void:
	match accepted_behavior:
		AcceptedBehavior.STAY:
			pass
		AcceptedBehavior.RETURN_HOME:
			reset_to_home()
		AcceptedBehavior.HIDE:
			visible = false
