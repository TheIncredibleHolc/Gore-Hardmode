Lights1 goldplate_f3dlite_material_030_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x49, 0x49, 0x49);

Gfx goldplate_gold64_rgba16_aligner[] = {gsSPEndDisplayList()};
u8 goldplate_gold64_rgba16[] = {
	#include "gold64.rgba16.inc.c"
};

Vtx goldplate_Plane_004_mesh_layer_1_vtx_0[4] = {
	{{ {-42, 0, 42}, 0, {-16, 2032}, {0, 127, 0, 255} }},
	{{ {42, 0, 42}, 0, {2032, 2032}, {0, 127, 0, 255} }},
	{{ {42, 0, -42}, 0, {2032, -16}, {0, 127, 0, 255} }},
	{{ {-42, 0, -42}, 0, {-16, -16}, {0, 127, 0, 255} }},
};

Gfx goldplate_Plane_004_mesh_layer_1_tri_0[] = {
	gsSPVertex(goldplate_Plane_004_mesh_layer_1_vtx_0 + 0, 4, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSPEndDisplayList(),
};


Gfx mat_goldplate_f3dlite_material_030[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(goldplate_f3dlite_material_030_lights),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, goldplate_gold64_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 4095, 128),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 16, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0),
	gsDPSetTileSize(0, 0, 0, 252, 252),
	gsSPEndDisplayList(),
};

Gfx goldplate_Plane_004_mesh_layer_1[] = {
	gsSPDisplayList(mat_goldplate_f3dlite_material_030),
	gsSPDisplayList(goldplate_Plane_004_mesh_layer_1_tri_0),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

