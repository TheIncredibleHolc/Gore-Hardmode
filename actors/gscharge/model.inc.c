Lights1 gscharge_f3dlite_material_lights = gdSPDefLights1(
	0xA, 0x0, 0x7F,
	0x20, 0x0, 0xFF, 0x28, 0x28, 0x28);

Vtx gscharge_Plane_mesh_layer_1_vtx_0[4] = {
	{{ {0, 100, 100}, 0, {-16, 1008}, {127, 0, 0, 255} }},
	{{ {0, -100, 100}, 0, {1008, 1008}, {127, 0, 0, 255} }},
	{{ {0, -100, -100}, 0, {1008, -16}, {127, 0, 0, 255} }},
	{{ {0, 100, -100}, 0, {-16, -16}, {127, 0, 0, 255} }},
};

Gfx gscharge_Plane_mesh_layer_1_tri_0[] = {
	gsSPVertex(gscharge_Plane_mesh_layer_1_vtx_0 + 0, 4, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSPEndDisplayList(),
};


Gfx mat_gscharge_f3dlite_material[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(gscharge_f3dlite_material_lights),
	gsSPEndDisplayList(),
};

Gfx gscharge_Plane_mesh_layer_1[] = {
	gsSPDisplayList(mat_gscharge_f3dlite_material),
	gsSPDisplayList(gscharge_Plane_mesh_layer_1_tri_0),
	gsSPEndDisplayList(),
};

Gfx gscharge_material_revert_render_settings[] = {
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

