void scroll_secretroom_dl_Skybox_mesh_layer_1_vtx_0() {
	int i = 0;
	int count = 478;
	int width = 1024 * 0x20;

	static int currentX = 0;
	int deltaX;
	Vtx *vertices = segmented_to_virtual(secretroom_dl_Skybox_mesh_layer_1_vtx_0);

	deltaX = (int)(1.0 * 0x20) % width;

	if (absi(currentX) > width) {
		deltaX -= (int)(absi(currentX) / width) * width * signum_positive(deltaX);
	}

	for (i = 0; i < count; i++) {
		vertices[i].n.tc[0] += deltaX;
	}
	currentX += deltaX;
}

void scroll_secretroom_dl_Skybox_001_mesh_layer_1_vtx_0() {
	int i = 0;
	int count = 478;
	int width = 1024 * 0x20;

	static int currentX = 0;
	int deltaX;
	Vtx *vertices = segmented_to_virtual(secretroom_dl_Skybox_001_mesh_layer_1_vtx_0);

	deltaX = (int)(1.0 * 0x20) % width;

	if (absi(currentX) > width) {
		deltaX -= (int)(absi(currentX) / width) * width * signum_positive(deltaX);
	}

	for (i = 0; i < count; i++) {
		vertices[i].n.tc[0] += deltaX;
	}
	currentX += deltaX;
}

void scroll_secretroom() {
	scroll_secretroom_dl_Skybox_mesh_layer_1_vtx_0();
	scroll_secretroom_dl_Skybox_001_mesh_layer_1_vtx_0();
};
