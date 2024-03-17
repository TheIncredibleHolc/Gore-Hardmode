Lights1 secretroom_dl_f3dlite_material_007_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x49, 0x49, 0x49);

Lights1 secretroom_dl_f3dlite_material_015_lights = gdSPDefLights1(
	0x61, 0x7F, 0x0,
	0xC6, 0xFF, 0x0, 0x49, 0x49, 0x49);

Lights1 secretroom_dl_f3dlite_material_019_lights = gdSPDefLights1(
	0x2, 0x0, 0x26,
	0x9, 0x0, 0x55, 0x49, 0x49, 0x49);

Lights0 secretroom_dl_f3dlite_material_016_lights = gdSPDefLights0(
	0xFF, 0xFF, 0xFF);

Lights1 secretroom_dl_f3dlite_material_017_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x49, 0x49, 0x49);

Vtx secretroom_dl_Death_Plane_mesh_layer_1_vtx_0[4] = {
	{{ {-22037, 0, 22037}, 0, {-16, 1008}, {0, 127, 0, 255} }},
	{{ {22037, 0, 22037}, 0, {1008, 1008}, {0, 127, 0, 255} }},
	{{ {22037, 0, -22037}, 0, {1008, -16}, {0, 127, 0, 255} }},
	{{ {-22037, 0, -22037}, 0, {-16, -16}, {0, 127, 0, 255} }},
};

Gfx secretroom_dl_Death_Plane_mesh_layer_1_tri_0[] = {
	gsSPVertex(secretroom_dl_Death_Plane_mesh_layer_1_vtx_0 + 0, 4, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSPEndDisplayList(),
};

Vtx secretroom_dl_Floor_mesh_layer_1_vtx_0[4] = {
	{{ {-7618, 0, 7618}, 0, {-16, 1008}, {0, 127, 0, 255} }},
	{{ {7618, 0, 7618}, 0, {1008, 1008}, {0, 127, 0, 255} }},
	{{ {7618, 0, -7618}, 0, {1008, -16}, {0, 127, 0, 255} }},
	{{ {-7618, 0, -7618}, 0, {-16, -16}, {0, 127, 0, 255} }},
};

Gfx secretroom_dl_Floor_mesh_layer_1_tri_0[] = {
	gsSPVertex(secretroom_dl_Floor_mesh_layer_1_vtx_0 + 0, 4, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSPEndDisplayList(),
};

Vtx secretroom_dl_platforms_015_mesh_layer_1_vtx_0[30] = {
	{{ {469, -62, -820}, 0, {1380, 6826}, {37, 120, 235, 255} }},
	{{ {270, 62, -473}, 0, {789, 7593}, {37, 120, 235, 255} }},
	{{ {545, 62, -2}, 0, {1606, 8634}, {37, 120, 235, 255} }},
	{{ {945, -62, -4}, 0, {2797, 8630}, {37, 120, 235, 255} }},
	{{ {945, -62, -4}, 0, {2797, 8630}, {37, 120, 21, 255} }},
	{{ {545, 62, -2}, 0, {1606, 8634}, {37, 120, 21, 255} }},
	{{ {274, 62, 471}, 0, {801, 9680}, {37, 120, 21, 255} }},
	{{ {476, -62, 816}, 0, {1400, 10444}, {37, 120, 21, 255} }},
	{{ {476, -62, 816}, 0, {1400, 10444}, {0, 120, 43, 255} }},
	{{ {274, 62, 471}, 0, {801, 9680}, {0, 120, 43, 255} }},
	{{ {-270, 62, 473}, 0, {-822, 9685}, {0, 120, 43, 255} }},
	{{ {-469, -62, 820}, 0, {-1413, 10453}, {0, 120, 43, 255} }},
	{{ {-469, -62, 820}, 0, {-1413, 10453}, {219, 120, 21, 255} }},
	{{ {-270, 62, 473}, 0, {-822, 9685}, {219, 120, 21, 255} }},
	{{ {-545, 62, 2}, 0, {-1639, 8644}, {219, 120, 21, 255} }},
	{{ {-945, -62, 4}, 0, {-2830, 8648}, {219, 120, 21, 255} }},
	{{ {274, 62, 471}, 0, {801, 9680}, {0, 127, 0, 255} }},
	{{ {545, 62, -2}, 0, {1606, 8634}, {0, 127, 0, 255} }},
	{{ {270, 62, -473}, 0, {789, 7593}, {0, 127, 0, 255} }},
	{{ {-545, 62, 2}, 0, {-1639, 8644}, {0, 127, 0, 255} }},
	{{ {-274, 62, -471}, 0, {-834, 7598}, {0, 127, 0, 255} }},
	{{ {-270, 62, 473}, 0, {-822, 9685}, {0, 127, 0, 255} }},
	{{ {-945, -62, 4}, 0, {-2830, 8648}, {219, 120, 235, 255} }},
	{{ {-545, 62, 2}, 0, {-1639, 8644}, {219, 120, 235, 255} }},
	{{ {-274, 62, -471}, 0, {-834, 7598}, {219, 120, 235, 255} }},
	{{ {-476, -62, -816}, 0, {-1433, 6834}, {219, 120, 235, 255} }},
	{{ {-476, -62, -816}, 0, {-1433, 6834}, {0, 120, 213, 255} }},
	{{ {-274, 62, -471}, 0, {-834, 7598}, {0, 120, 213, 255} }},
	{{ {270, 62, -473}, 0, {789, 7593}, {0, 120, 213, 255} }},
	{{ {469, -62, -820}, 0, {1380, 6826}, {0, 120, 213, 255} }},
};

Gfx secretroom_dl_platforms_015_mesh_layer_1_tri_0[] = {
	gsSPVertex(secretroom_dl_platforms_015_mesh_layer_1_vtx_0 + 0, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSP1Triangle(8, 9, 10, 0),
	gsSP1Triangle(8, 10, 11, 0),
	gsSP1Triangle(12, 13, 14, 0),
	gsSP1Triangle(12, 14, 15, 0),
	gsSPVertex(secretroom_dl_platforms_015_mesh_layer_1_vtx_0 + 16, 14, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(2, 3, 0, 0),
	gsSP1Triangle(2, 4, 3, 0),
	gsSP1Triangle(3, 5, 0, 0),
	gsSP1Triangle(6, 7, 8, 0),
	gsSP1Triangle(6, 8, 9, 0),
	gsSP1Triangle(10, 11, 12, 0),
	gsSP1Triangle(10, 12, 13, 0),
	gsSPEndDisplayList(),
};

Vtx secretroom_dl_Walls_mesh_layer_1_vtx_0[75] = {
	{{ {0, -2109, -6136}, 0, {1008, 496}, {63, 0, 146, 255} }},
	{{ {0, 2109, -6136}, 0, {1008, -16}, {63, 0, 146, 255} }},
	{{ {5314, 2109, -3068}, 0, {837, -16}, {63, 0, 146, 255} }},
	{{ {5314, -2109, -3068}, 0, {837, 496}, {63, 0, 146, 255} }},
	{{ {5314, -2109, -3068}, 0, {837, 496}, {127, 0, 0, 255} }},
	{{ {5314, 2109, -3068}, 0, {837, -16}, {127, 0, 0, 255} }},
	{{ {5314, 2109, 3068}, 0, {667, -16}, {127, 0, 0, 255} }},
	{{ {5314, -2109, 3068}, 0, {667, 496}, {127, 0, 0, 255} }},
	{{ {5314, -2109, 3068}, 0, {667, 496}, {63, 0, 110, 255} }},
	{{ {5314, 2109, 3068}, 0, {667, -16}, {63, 0, 110, 255} }},
	{{ {0, 2109, 6136}, 0, {496, -16}, {63, 0, 110, 255} }},
	{{ {0, -2109, 6136}, 0, {496, 496}, {63, 0, 110, 255} }},
	{{ {0, -2109, 6136}, 0, {496, 496}, {193, 0, 110, 255} }},
	{{ {0, 2109, 6136}, 0, {496, -16}, {193, 0, 110, 255} }},
	{{ {-5314, 2109, 3068}, 0, {325, -16}, {193, 0, 110, 255} }},
	{{ {-5314, -2109, 3068}, 0, {325, 496}, {193, 0, 110, 255} }},
	{{ {-5314, -2109, 3068}, 0, {325, 496}, {129, 0, 0, 255} }},
	{{ {-5314, 2109, 3068}, 0, {325, -16}, {129, 0, 0, 255} }},
	{{ {-5314, 2109, -3068}, 0, {155, -16}, {129, 0, 0, 255} }},
	{{ {-5314, -2109, -3068}, 0, {155, 496}, {129, 0, 0, 255} }},
	{{ {-5314, -2109, -3068}, 0, {155, 496}, {193, 0, 146, 255} }},
	{{ {-5314, 2109, -3068}, 0, {155, -16}, {193, 0, 146, 255} }},
	{{ {0, 2109, -6136}, 0, {-16, -16}, {193, 0, 146, 255} }},
	{{ {0, -2109, -6136}, 0, {-16, 496}, {193, 0, 146, 255} }},
	{{ {4980, -2109, -2860}, 0, {837, 438}, {193, 0, 110, 255} }},
	{{ {4980, 2109, -2860}, 0, {837, 129}, {193, 0, 110, 255} }},
	{{ {77, 2109, -5691}, 0, {1008, 129}, {193, 0, 110, 255} }},
	{{ {77, -2109, -5691}, 0, {1008, 438}, {193, 0, 110, 255} }},
	{{ {4980, 2109, 2801}, 0, {667, 129}, {129, 0, 0, 255} }},
	{{ {4980, 2109, -2860}, 0, {837, 129}, {129, 0, 0, 255} }},
	{{ {4980, -2109, -2860}, 0, {837, 438}, {129, 0, 0, 255} }},
	{{ {4980, -2109, 2801}, 0, {667, 438}, {129, 0, 0, 255} }},
	{{ {77, 2109, 5632}, 0, {496, 129}, {193, 0, 146, 255} }},
	{{ {4980, 2109, 2801}, 0, {667, 129}, {193, 0, 146, 255} }},
	{{ {4980, -2109, 2801}, 0, {667, 438}, {193, 0, 146, 255} }},
	{{ {77, -2109, 5632}, 0, {496, 438}, {193, 0, 146, 255} }},
	{{ {-4826, 2109, 2801}, 0, {325, 129}, {63, 0, 146, 255} }},
	{{ {77, 2109, 5632}, 0, {496, 129}, {63, 0, 146, 255} }},
	{{ {77, -2109, 5632}, 0, {496, 438}, {63, 0, 146, 255} }},
	{{ {-4826, -2109, 2801}, 0, {325, 438}, {63, 0, 146, 255} }},
	{{ {-4826, -2109, -2860}, 0, {155, 438}, {127, 0, 0, 255} }},
	{{ {-4826, 2109, -2860}, 0, {155, 129}, {127, 0, 0, 255} }},
	{{ {-4826, 2109, 2801}, 0, {325, 129}, {127, 0, 0, 255} }},
	{{ {-4826, -2109, 2801}, 0, {325, 438}, {127, 0, 0, 255} }},
	{{ {77, -2109, -5691}, 0, {-16, 438}, {63, 0, 110, 255} }},
	{{ {77, 2109, -5691}, 0, {-16, 129}, {63, 0, 110, 255} }},
	{{ {-4826, 2109, -2860}, 0, {155, 129}, {63, 0, 110, 255} }},
	{{ {-4826, -2109, -2860}, 0, {155, 438}, {63, 0, 110, 255} }},
	{{ {77, 2109, -5691}, 0, {243, 524}, {0, 127, 0, 255} }},
	{{ {4980, 2109, -2860}, 0, {439, 637}, {0, 127, 0, 255} }},
	{{ {5314, 2109, -3068}, 0, {453, 629}, {0, 127, 0, 255} }},
	{{ {4980, 2109, 2801}, 0, {439, 864}, {0, 127, 0, 255} }},
	{{ {5314, 2109, 3068}, 0, {453, 875}, {0, 127, 0, 255} }},
	{{ {0, 2109, 6136}, 0, {240, 998}, {0, 127, 0, 255} }},
	{{ {77, 2109, 5632}, 0, {243, 978}, {0, 127, 0, 255} }},
	{{ {-5314, 2109, 3068}, 0, {27, 875}, {0, 127, 0, 255} }},
	{{ {-4826, 2109, 2801}, 0, {47, 864}, {0, 127, 0, 255} }},
	{{ {-4826, 2109, -2860}, 0, {47, 637}, {0, 127, 0, 255} }},
	{{ {-5314, 2109, -3068}, 0, {27, 629}, {0, 127, 0, 255} }},
	{{ {0, 2109, -6136}, 0, {240, 506}, {0, 127, 0, 255} }},
	{{ {77, -2109, 5632}, 0, {755, 978}, {0, 129, 0, 255} }},
	{{ {4980, -2109, 2801}, 0, {951, 864}, {0, 129, 0, 255} }},
	{{ {5314, -2109, 3068}, 0, {965, 875}, {0, 129, 0, 255} }},
	{{ {4980, -2109, -2860}, 0, {951, 637}, {0, 129, 0, 255} }},
	{{ {4980, -2109, -2860}, 0, {951, 637}, {0, 129, 0, 255} }},
	{{ {5314, -2109, -3068}, 0, {965, 629}, {0, 129, 0, 255} }},
	{{ {5314, -2109, 3068}, 0, {965, 875}, {0, 129, 0, 255} }},
	{{ {0, -2109, -6136}, 0, {752, 506}, {0, 129, 0, 255} }},
	{{ {77, -2109, -5691}, 0, {755, 524}, {0, 129, 0, 255} }},
	{{ {-5314, -2109, -3068}, 0, {539, 629}, {0, 129, 0, 255} }},
	{{ {-4826, -2109, -2860}, 0, {559, 637}, {0, 129, 0, 255} }},
	{{ {-4826, -2109, 2801}, 0, {559, 864}, {0, 129, 0, 255} }},
	{{ {-5314, -2109, 3068}, 0, {539, 875}, {0, 129, 0, 255} }},
	{{ {0, -2109, 6136}, 0, {752, 998}, {0, 129, 0, 255} }},
	{{ {77, -2109, 5632}, 0, {755, 978}, {0, 129, 0, 255} }},
};

Gfx secretroom_dl_Walls_mesh_layer_1_tri_0[] = {
	gsSPVertex(secretroom_dl_Walls_mesh_layer_1_vtx_0 + 0, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSP1Triangle(8, 9, 10, 0),
	gsSP1Triangle(8, 10, 11, 0),
	gsSP1Triangle(12, 13, 14, 0),
	gsSP1Triangle(12, 14, 15, 0),
	gsSPVertex(secretroom_dl_Walls_mesh_layer_1_vtx_0 + 16, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSP1Triangle(8, 9, 10, 0),
	gsSP1Triangle(8, 10, 11, 0),
	gsSP1Triangle(12, 13, 14, 0),
	gsSP1Triangle(12, 14, 15, 0),
	gsSPVertex(secretroom_dl_Walls_mesh_layer_1_vtx_0 + 32, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSP1Triangle(8, 9, 10, 0),
	gsSP1Triangle(8, 10, 11, 0),
	gsSP1Triangle(12, 13, 14, 0),
	gsSP1Triangle(12, 14, 15, 0),
	gsSPVertex(secretroom_dl_Walls_mesh_layer_1_vtx_0 + 48, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(3, 2, 1, 0),
	gsSP1Triangle(3, 4, 2, 0),
	gsSP1Triangle(5, 4, 3, 0),
	gsSP1Triangle(5, 3, 6, 0),
	gsSP1Triangle(7, 5, 6, 0),
	gsSP1Triangle(7, 6, 8, 0),
	gsSP1Triangle(7, 8, 9, 0),
	gsSP1Triangle(10, 7, 9, 0),
	gsSP1Triangle(9, 11, 10, 0),
	gsSP1Triangle(9, 0, 11, 0),
	gsSP1Triangle(0, 2, 11, 0),
	gsSP1Triangle(12, 13, 14, 0),
	gsSP1Triangle(15, 14, 13, 0),
	gsSPVertex(secretroom_dl_Walls_mesh_layer_1_vtx_0 + 64, 11, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(3, 1, 0, 0),
	gsSP1Triangle(3, 0, 4, 0),
	gsSP1Triangle(5, 3, 4, 0),
	gsSP1Triangle(5, 4, 6, 0),
	gsSP1Triangle(5, 6, 7, 0),
	gsSP1Triangle(8, 5, 7, 0),
	gsSP1Triangle(7, 9, 8, 0),
	gsSP1Triangle(7, 10, 9, 0),
	gsSP1Triangle(10, 2, 9, 0),
	gsSPEndDisplayList(),
};

Vtx secretroom_dl_Welcome_Wall_mesh_layer_1_vtx_0[8] = {
	{{ {1655, -582, 100}, 0, {-31717, 33238}, {0, 0, 127, 255} }},
	{{ {1655, 582, 100}, 0, {-31499, 16420}, {0, 0, 127, 255} }},
	{{ {-1655, 582, 100}, 0, {-66174, 16315}, {0, 0, 127, 255} }},
	{{ {-1655, -582, 100}, 0, {-66392, 33132}, {0, 0, 127, 255} }},
	{{ {-1655, -582, -100}, 0, {-28688, 8176}, {0, 129, 0, 255} }},
	{{ {1655, -582, -100}, 0, {-20496, 8176}, {0, 129, 0, 255} }},
	{{ {1655, -582, 100}, 0, {-20496, 4080}, {0, 129, 0, 255} }},
	{{ {-1655, -582, 100}, 0, {-28688, 4080}, {0, 129, 0, 255} }},
};

Gfx secretroom_dl_Welcome_Wall_mesh_layer_1_tri_0[] = {
	gsSPVertex(secretroom_dl_Welcome_Wall_mesh_layer_1_vtx_0 + 0, 8, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSPEndDisplayList(),
};

Vtx secretroom_dl_Welcome_Wall_mesh_layer_1_vtx_1[16] = {
	{{ {-1655, -582, 100}, 0, {368, 1008}, {129, 0, 0, 255} }},
	{{ {-1655, 582, 100}, 0, {624, 1008}, {129, 0, 0, 255} }},
	{{ {-1655, 582, -100}, 0, {624, 752}, {129, 0, 0, 255} }},
	{{ {-1655, -582, -100}, 0, {368, 752}, {129, 0, 0, 255} }},
	{{ {-1655, -582, -100}, 0, {368, 752}, {0, 0, 129, 255} }},
	{{ {-1655, 582, -100}, 0, {624, 752}, {0, 0, 129, 255} }},
	{{ {1655, 582, -100}, 0, {624, 496}, {0, 0, 129, 255} }},
	{{ {1655, -582, -100}, 0, {368, 496}, {0, 0, 129, 255} }},
	{{ {1655, -582, -100}, 0, {368, 496}, {127, 0, 0, 255} }},
	{{ {1655, 582, -100}, 0, {624, 496}, {127, 0, 0, 255} }},
	{{ {1655, 582, 100}, 0, {624, 240}, {127, 0, 0, 255} }},
	{{ {1655, -582, 100}, 0, {368, 240}, {127, 0, 0, 255} }},
	{{ {1655, 582, -100}, 0, {624, 496}, {0, 127, 0, 255} }},
	{{ {-1655, 582, -100}, 0, {880, 496}, {0, 127, 0, 255} }},
	{{ {-1655, 582, 100}, 0, {880, 240}, {0, 127, 0, 255} }},
	{{ {1655, 582, 100}, 0, {624, 240}, {0, 127, 0, 255} }},
};

Gfx secretroom_dl_Welcome_Wall_mesh_layer_1_tri_1[] = {
	gsSPVertex(secretroom_dl_Welcome_Wall_mesh_layer_1_vtx_1 + 0, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSP1Triangle(8, 9, 10, 0),
	gsSP1Triangle(8, 10, 11, 0),
	gsSP1Triangle(12, 13, 14, 0),
	gsSP1Triangle(12, 14, 15, 0),
	gsSPEndDisplayList(),
};

Gfx mat_secretroom_dl_f3dlite_material_007[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(secretroom_dl_f3dlite_material_007_lights),
	gsSPEndDisplayList(),
};

Gfx mat_secretroom_dl_f3dlite_material_015[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(secretroom_dl_f3dlite_material_015_lights),
	gsSPEndDisplayList(),
};

Gfx mat_secretroom_dl_f3dlite_material_003[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, ENVIRONMENT, 0, 0, 0, TEXEL0, 0, 0, 0, ENVIRONMENT),
	gsSPSetGeometryMode(G_TEXTURE_GEN),
	gsSPTexture(1984, 1984, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, secretroom_dl_SUPER_MARIO_64_184368CA_0_2_all_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 8, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_secretroom_dl_f3dlite_material_003[] = {
	gsDPPipeSync(),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsSPEndDisplayList(),
};

Gfx mat_secretroom_dl_f3dlite_material_019[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(secretroom_dl_f3dlite_material_019_lights),
	gsSPEndDisplayList(),
};

Gfx mat_secretroom_dl_f3dlite_material_016[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights0(secretroom_dl_f3dlite_material_016_lights),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, secretroom_dl_Intro_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 524287, 8),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 256, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 9, 0, G_TX_WRAP | G_TX_NOMIRROR, 10, 0),
	gsDPSetTileSize(0, 0, 0, 4091, 2044),
	gsSPEndDisplayList(),
};

Gfx mat_secretroom_dl_f3dlite_material_017[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(secretroom_dl_f3dlite_material_017_lights),
	gsSPEndDisplayList(),
};

Gfx secretroom_dl_Death_Plane_mesh_layer_1[] = {
	gsSPDisplayList(mat_secretroom_dl_f3dlite_material_007),
	gsSPDisplayList(secretroom_dl_Death_Plane_mesh_layer_1_tri_0),
	gsSPEndDisplayList(),
};

Gfx secretroom_dl_Floor_mesh_layer_1[] = {
	gsSPDisplayList(mat_secretroom_dl_f3dlite_material_015),
	gsSPDisplayList(secretroom_dl_Floor_mesh_layer_1_tri_0),
	gsSPEndDisplayList(),
};

Gfx secretroom_dl_platforms_015_mesh_layer_1[] = {
	gsSPDisplayList(mat_secretroom_dl_f3dlite_material_003),
	gsSPDisplayList(secretroom_dl_platforms_015_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_secretroom_dl_f3dlite_material_003),
	gsSPEndDisplayList(),
};

Gfx secretroom_dl_Walls_mesh_layer_1[] = {
	gsSPDisplayList(mat_secretroom_dl_f3dlite_material_019),
	gsSPDisplayList(secretroom_dl_Walls_mesh_layer_1_tri_0),
	gsSPEndDisplayList(),
};

Gfx secretroom_dl_Welcome_Wall_mesh_layer_1[] = {
	gsSPDisplayList(mat_secretroom_dl_f3dlite_material_016),
	gsSPDisplayList(secretroom_dl_Welcome_Wall_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_secretroom_dl_f3dlite_material_017),
	gsSPDisplayList(secretroom_dl_Welcome_Wall_mesh_layer_1_tri_1),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

