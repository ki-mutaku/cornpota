class_name ServingBowl
extends DirectDraggableItem

signal soup_delivered(soup: Variant)
signal soup_changed(soup: Variant)

var soup: Variant = null

@onready var soup_fill: Polygon2D = %SoupFill
@onready var bowl_label: Label = %BowlLabel


func _ready() -> void:
	super._ready()
	drag_finished.connect(_on_drag_finished)
	clear_soup()


func fill_soup(value: Variant) -> bool:
	if value == null or has_soup():
		return false
	soup = value
	drag_tag = &"soup"
	soup_fill.visible = true
	bowl_label.text = "コンポタ"
	soup_changed.emit(soup)
	return true


func clear_soup() -> void:
	soup = null
	drag_tag = &"bowl"
	if is_node_ready():
		soup_fill.visible = false
		bowl_label.text = "器"
	soup_changed.emit(soup)


func has_soup() -> bool:
	return soup != null


func get_interaction_payload() -> Variant:
	return soup if has_soup() else self


func reset_bowl() -> void:
	clear_soup()
	reset_to_home()


func _on_drag_finished(
	_item: DirectDraggableItem,
	accepted: bool,
	target: DirectDropTarget,
) -> void:
	if not accepted or target == null or not has_soup():
		return
	if target.accepted_tag != &"soup":
		return

	var delivered_soup: Variant = soup
	clear_soup()
	soup_delivered.emit(delivered_soup)
