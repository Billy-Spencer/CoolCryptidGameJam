extends Node2D

onready var sprite = $sprite
onready var area = $collision_area
onready var tween = $tween

var clear = false


func _ready():
	make_colision_polygon()


#makes an shape for the collision detector object to use which is the same shape as the sprite of the object
func make_colision_polygon():
	var texture = sprite.get_texture()

	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_data())

	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()))
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
		collision_polygon.polygon = poly
		area.add_child(collision_polygon)

		# Generated polygon will not take into account the half-width and half-height offset
		# of the image when "centered" is on. So move it backwards by this amount so it lines up.
		if sprite.centered:
			collision_polygon.position -= bitmap.get_size()/2


func remove():
	clear = true
	tween.interpolate_property(self, "modulate",
		Color(1,1,1,1), Color(1,1,1,0), settings.stumble_time,
		Tween.TRANS_LINEAR)
		
	tween.start()


func _on_tween_tween_completed(object, key):
	queue_free()
