Vtx blood_mist_Plane_mesh_layer_5_vtx_0[4] = {
	{{ {100, 100, 0}, 0, {-16, 16368}, {255, 255, 255, 255} }},
	{{ {100, -100, 0}, 0, {16368, 16368}, {255, 255, 255, 255} }},
	{{ {-100, -100, 0}, 0, {16368, -16}, {255, 255, 255, 255} }},
	{{ {-100, 100, 0}, 0, {-16, -16}, {255, 255, 255, 255} }},
};

Gfx blood_mist_Plane_mesh_layer_5_tri_0[] = {
	gsSPVertex(blood_mist_Plane_mesh_layer_5_vtx_0 + 0, 4, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSPEndDisplayList(),
};


Gfx mat_blood_mist_f3dlite_material_006[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, TEXEL0, 0, ENVIRONMENT, 0, TEXEL0, 0, SHADE, 0, TEXEL0, 0, ENVIRONMENT, 0),
	gsSPClearGeometryMode(G_SHADE | G_CULL_BACK | G_LIGHTING | G_SHADING_SMOOTH),
	gsDPSetTextureFilter(G_TF_POINT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, blood_mist_lasercharge_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 262143, 16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 128, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 9, 0, G_TX_WRAP | G_TX_NOMIRROR, 9, 0),
	gsDPSetTileSize(0, 0, 0, 2044, 2044),
	gsSPEndDisplayList(),
};

Gfx mat_revert_blood_mist_f3dlite_material_006[] = {
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_SHADE | G_CULL_BACK | G_LIGHTING | G_SHADING_SMOOTH),
	gsSPEndDisplayList(),
};

Gfx blood_mist_Plane_mesh_layer_5[] = {
	gsSPDisplayList(mat_blood_mist_f3dlite_material_006),
	gsSPDisplayList(blood_mist_Plane_mesh_layer_5_tri_0),
	gsSPDisplayList(mat_revert_blood_mist_f3dlite_material_006),
	gsSPEndDisplayList(),
};

Gfx blood_mist_material_revert_render_settings[] = {
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

