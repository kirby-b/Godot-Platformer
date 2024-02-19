extends ParallaxBackground

func _process(delta):
	scroll_offset.x += 10 * delta
	scroll_offset.y = 0
