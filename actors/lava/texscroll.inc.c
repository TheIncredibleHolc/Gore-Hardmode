void scroll_lava_Plane_mesh_layer_1_vtx_0() {
	int i = 0;
	int count = 4;
	int width = 32 * 0x20;
	int height = 32 * 0x20;

	static int currentX = 0;
	int deltaX;
	static int currentY = 0;
	int deltaY;
	Vtx *vertices = segmented_to_virtual(lava_Plane_mesh_layer_1_vtx_0);

	deltaX = (int)(100.0 * 0x20) % width;
	deltaY = (int)(4.0 * 0x20) % height;

	if (absi(currentX) > width) {
		deltaX -= (int)(absi(currentX) / width) * width * signum_positive(deltaX);
	}
	if (absi(currentY) > height) {
		deltaY -= (int)(absi(currentY) / height) * height * signum_positive(deltaY);
	}

	for (i = 0; i < count; i++) {
		vertices[i].n.tc[0] += deltaX;
		vertices[i].n.tc[1] += deltaY;
	}
	currentX += deltaX;	currentY += deltaY;
}

void scroll_gfx_mat_lava_f3dlite_material_001() {
	Gfx *mat = segmented_to_virtual(mat_lava_f3dlite_material_001);
	static int interval_tex_lava_f3dlite_material_001 = 10;
	static int cur_interval_tex_lava_f3dlite_material_001 = 10;

	if (--cur_interval_tex_lava_f3dlite_material_001 <= 0) {
		shift_s(mat, 14, PACK_TILESIZE(0, 10));
		shift_t(mat, 14, PACK_TILESIZE(0, 10));
		cur_interval_tex_lava_f3dlite_material_001 = interval_tex_lava_f3dlite_material_001;
	}

};

void scroll_actor_geo_lava() {
	scroll_lava_Plane_mesh_layer_1_vtx_0();
	scroll_gfx_mat_lava_f3dlite_material_001();
};
