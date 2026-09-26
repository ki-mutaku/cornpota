class_name DirectDropTarget
extends Area2D

signal item_received(payload: Variant, source: DirectDraggableItem)
signal highlight_changed(active: bool)

@export var accepted_tag: StringName = &"ingredient"
@export var enabled: bool = true

var is_highlighted: bool = false


func accepts(item: DirectDraggableItem) -> bool:
	if not enabled:
		return false
	return accepted_tag == &"" or item.drag_tag == accepted_tag


func try_receive(item: DirectDraggableItem) -> bool:
	if not accepts(item):
		return false

	item_received.emit(item.get_interaction_payload(), item)
	return true


func set_highlighted(active: bool) -> void:
	if is_highlighted == active:
		return
	is_highlighted = active
	highlight_changed.emit(is_highlighted)
