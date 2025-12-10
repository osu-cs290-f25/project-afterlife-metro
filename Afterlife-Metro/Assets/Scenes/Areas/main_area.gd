extends Node2D

func _ready():
	find_broken_tiles(self)


func find_broken_tiles(node):
	if node is TileMapLayer:
		print("CHECKING: ", node.name)
		check_layer(node)

	for child in node.get_children():
		find_broken_tiles(child)


func check_layer(layer: TileMapLayer):
	for cell in layer.get_used_cells():
		var source_id = layer.get_cell_source_id(cell)
		var atlas_coords = layer.get_cell_atlas_coords(cell)

		if source_id == -1:
			continue

		var tileset := layer.tile_set

		# Validate source exists
		if not tileset.has_source(source_id):
			print("❌ Missing source at ", layer.name, " cell: ", cell)
			continue

		var src := tileset.get_source(source_id)

		if src is TileSetAtlasSource:
			if not src.has_tile(atlas_coords):
				print("❌ INVALID TILE in ", layer.name, " at cell ", cell,
					  " referencing atlas coords ", atlas_coords)
