extends TileMapLayer

func _ready():
	var tilemap := self

	for cell in tilemap.get_used_cells():
		var source_id = tilemap.get_cell_source_id(cell)
		var atlas_coords = tilemap.get_cell_atlas_coords(cell)

		# If the tileset or source is missing, clear the tile
		if source_id == -1 or not tilemap.tile_set.has_source(source_id):
			tilemap.set_cell(cell, -1)
			continue

		var src = tilemap.tile_set.get_source(source_id)

		# If atlas tile no longer exists → clear
		if src is TileSetAtlasSource:
			if not src.has_tile(atlas_coords):
				tilemap.set_cell(cell, -1)

	print("Invalid tiles cleared for TileMapLayer: ", name)
