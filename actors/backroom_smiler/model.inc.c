Gfx backroom_smiler_smiler_sprite_low_rgba32_aligner[] = {gsSPEndDisplayList()};
u8 backroom_smiler_smiler_sprite_low_rgba32[] = {
	#include "actors/backroom_smiler/smiler_sprite_low.rgba32.inc.c"
};

Vtx backroom_smiler_Plane_mesh_layer_5_vtx_cull[8] = {
	{{ {-147, -147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {-147, 147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {-147, 147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {-147, -147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {147, -147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {147, 147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {147, 147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
	{{ {147, -147, 0}, 0, {0, 0}, {0, 0, 0, 0} }},
};

Vtx backroom_smiler_Plane_mesh_layer_5_vtx_0[4] = {
	{{ {-147, -147, 0}, 0, {-16, 4080}, {0, 0, 127, 255} }},
	{{ {147, -147, 0}, 0, {4080, 4080}, {0, 0, 127, 255} }},
	{{ {147, 147, 0}, 0, {4080, -16}, {0, 0, 127, 255} }},
	{{ {-147, 147, 0}, 0, {-16, -16}, {0, 0, 127, 255} }},
};

Gfx backroom_smiler_Plane_mesh_layer_5_tri_0[] = {
	gsSPVertex(backroom_smiler_Plane_mesh_layer_5_vtx_0 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSPEndDisplayList(),
};


Gfx mat_backroom_smiler_f3dlite_material[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(1, 0, TEXEL0, 0, TEXEL0, 0, PRIMITIVE, 0, 1, 0, TEXEL0, 0, TEXEL0, 0, PRIMITIVE, 0),
	gsSPGeometryMode(G_CULL_BACK, 0),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetPrimColor(0, 0, 255, 255, 255, 255),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_32b_LOAD_BLOCK, 1, backroom_smiler_smiler_sprite_low_rgba32),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_32b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 16383, 32),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_32b, 32, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 7, 0),
	gsDPSetTileSize(0, 0, 0, 508, 508),
	gsSPEndDisplayList(),
};

Gfx mat_revert_backroom_smiler_f3dlite_material[] = {
	gsDPPipeSync(),
	gsSPGeometryMode(0, G_CULL_BACK),
	gsSPEndDisplayList(),
};

Gfx backroom_smiler_Plane_mesh_layer_5[] = {
	gsSPClearGeometryMode(G_LIGHTING),
	gsSPVertex(backroom_smiler_Plane_mesh_layer_5_vtx_cull + 0, 8, 0),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPCullDisplayList(0, 7),
	gsSPDisplayList(mat_backroom_smiler_f3dlite_material),
	gsSPDisplayList(backroom_smiler_Plane_mesh_layer_5_tri_0),
	gsSPDisplayList(mat_revert_backroom_smiler_f3dlite_material),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

