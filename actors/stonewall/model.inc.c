Lights1 stonewall_f3dlite_material_062_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x49, 0x49, 0x49);

Lights1 stonewall_f3dlite_material_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x49, 0x49, 0x49);

Gfx stonewall_dark_stars_ci8_aligner[] = {gsSPEndDisplayList()};
u8 stonewall_dark_stars_ci8[] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x01, 
	0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x05, 0x05, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x05, 0x00, 
	0x00, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00, 
	0x06, 0x00, 0x07, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x00, 0x03, 0x03, 0x03, 0x03, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x04, 0x03, 
	0x03, 0x01, 0x03, 0x04, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
	0x08, 0x08, 0x09, 0x09, 0x08, 0x01, 0x03, 0x00, 
	0x00, 0x03, 0x03, 0x0a, 0x09, 0x09, 0x09, 0x09, 
	0x09, 0x09, 0x09, 0x09, 0x0b, 0x0b, 0x09, 0x0c, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x09, 0x09, 0x0e, 0x0d, 0x09, 0x00, 0x03, 0x03, 
	0x05, 0x03, 0x03, 0x08, 0x0d, 0x0d, 0x0f, 0x10, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x11, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x09, 0x08, 0x08, 0x0d, 0x12, 0x00, 0x00, 0x13, 
	0x03, 0x03, 0x03, 0x08, 0x0d, 0x09, 0x08, 0x0c, 
	0x0d, 0x0d, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x0d, 
	0x08, 0x03, 0x00, 0x08, 0x08, 0x00, 0x15, 0x14, 
	0x16, 0x0d, 0x08, 0x08, 0x00, 0x00, 0x03, 0x00, 
	0x09, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x16, 0x16, 0x16, 0x16, 0x14, 0x14, 0x14, 0x0d, 
	0x00, 0x03, 0x03, 0x03, 0x00, 0x0d, 0x16, 0x16, 
	0x17, 0x18, 0x16, 0x0d, 0x08, 0x13, 0x03, 0x03, 
	0x0a, 0x14, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x14, 
	0x09, 0x03, 0x03, 0x00, 0x0d, 0x16, 0x16, 0x16, 
	0x0d, 0x16, 0x17, 0x16, 0x0d, 0x08, 0x00, 0x00, 
	0x19, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x14, 0x10, 0x0d, 0x16, 0x16, 0x16, 0x09, 
	0x08, 0x00, 0x14, 0x16, 0x16, 0x0d, 0x09, 0x09, 
	0x14, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x14, 0x14, 0x14, 0x1a, 0x1a, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x16, 0x14, 0x14, 0x1b, 0x08, 0x08, 
	0x00, 0x00, 0x08, 0x14, 0x16, 0x16, 0x14, 0x14, 
	0x1c, 0x16, 0x16, 0x16, 0x14, 0x14, 0x14, 0x14, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x1d, 0x14, 0x14, 0x14, 
	0x14, 0x1e, 0x08, 0x03, 0x03, 0x13, 0x03, 0x00, 
	0x00, 0x03, 0x03, 0x03, 0x00, 0x08, 0x08, 0x09, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x08, 0x08, 0x09, 0x09, 0x09, 0x15, 0x0d, 0x0d, 
	0x0d, 0x14, 0x14, 0x09, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x03, 0x03, 0x03, 0x01, 0x00, 0x09, 0x0d, 
	0x09, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
	0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
	0x08, 0x0d, 0x14, 0x1a, 0x14, 0x08, 0x00, 0x1f, 
	0x08, 0x03, 0x00, 0x03, 0x00, 0x0d, 0x14, 0x0d, 
	0x08, 0x00, 0x00, 0x00, 0x20, 0x08, 0x00, 0x00, 
	0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 
	0x09, 0x0d, 0x14, 0x16, 0x14, 0x08, 0x21, 0x08, 
	0x08, 0x0c, 0x20, 0x00, 0x00, 0x14, 0x16, 0x14, 
	0x0d, 0x0d, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x0d, 0x14, 0x14, 0x16, 0x09, 0x08, 0x08, 0x0d, 
	0x0d, 0x0d, 0x09, 0x22, 0x00, 0x09, 0x23, 0x16, 
	0x14, 0x14, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x10, 0x10, 0x24, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x0d, 0x14, 0x16, 0x0d, 0x08, 0x08, 0x0d, 0x0d, 
	0x0d, 0x14, 0x1d, 0x09, 0x08, 0x08, 0x14, 0x23, 
	0x14, 0x14, 0x0d, 0x0d, 0x0d, 0x0d, 0x09, 0x0e, 
	0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x19, 0x09, 
	0x09, 0x0d, 0x0d, 0x08, 0x08, 0x09, 0x09, 0x08, 
	0x08, 0x08, 0x09, 0x0d, 0x09, 0x08, 0x08, 0x0d, 
	0x0d, 0x09, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x00, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x25, 0x00, 
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
	0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x00, 0x00, 
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
	0x00, 0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x10, 0x10, 0x09, 0x09, 
	0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x10, 0x0d, 
	0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 0x0d, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x1d, 0x0d, 0x14, 0x1e, 
	0x14, 0x1d, 0x14, 0x1d, 0x1d, 0x0d, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x26, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x26, 
	0x16, 0x16, 0x16, 0x16, 0x27, 0x27, 0x28, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x26, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x14, 0x14, 0x1a, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x16, 0x14, 0x14, 0x14, 0x14, 0x14, 
	0x1c, 0x1c, 0x16, 0x1c, 0x14, 0x14, 0x16, 0x14, 
	0x14, 0x14, 0x14, 0x14, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x1c, 0x16, 
	0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 
	0x23, 0x26, 0x28, 0x16, 0x16, 0x16, 0x16, 0x16, 
	
};

Gfx stonewall_dark_stars_pal_rgba16_aligner[] = {gsSPEndDisplayList()};
u8 stonewall_dark_stars_pal_rgba16[] = {
	0x4a, 0x53, 0x4a, 0x93, 0x52, 0x93, 0x52, 0x95, 
	0x4a, 0x55, 0x5a, 0x95, 0x42, 0x13, 0x52, 0x97, 
	0x42, 0x11, 0x39, 0xcf, 0x4a, 0x11, 0x3a, 0x11, 
	0x3a, 0x0f, 0x31, 0x8d, 0x31, 0xcd, 0x31, 0x8f, 
	0x39, 0x8f, 0x31, 0x4d, 0x39, 0xcd, 0x52, 0x55, 
	0x29, 0x4b, 0x31, 0xcf, 0x21, 0x09, 0x20, 0xc7, 
	0x18, 0xc7, 0x41, 0xd1, 0x29, 0x0b, 0x29, 0x4d, 
	0x29, 0x09, 0x31, 0x4b, 0x29, 0x8b, 0x42, 0x53, 
	0x42, 0x51, 0x4a, 0x13, 0x4a, 0x51, 0x21, 0x0b, 
	0x39, 0x8d, 0x52, 0x53, 0x21, 0x4b, 0x29, 0x49, 
	0x21, 0x49, 
};

Gfx stonewall_dark_bricks_ci8_aligner[] = {gsSPEndDisplayList()};
u8 stonewall_dark_bricks_ci8[] = {
	0x00, 0x01, 0x01, 0x01, 0x02, 0x03, 0x04, 0x03, 
	0x05, 0x01, 0x00, 0x00, 0x01, 0x06, 0x05, 0x04, 
	0x00, 0x07, 0x08, 0x07, 0x05, 0x07, 0x04, 0x07, 
	0x05, 0x01, 0x04, 0x07, 0x07, 0x05, 0x06, 0x03, 
	0x00, 0x01, 0x02, 0x02, 0x02, 0x03, 0x04, 0x03, 
	0x05, 0x06, 0x00, 0x00, 0x01, 0x06, 0x05, 0x04, 
	0x00, 0x07, 0x08, 0x03, 0x05, 0x05, 0x04, 0x00, 
	0x05, 0x01, 0x04, 0x00, 0x07, 0x05, 0x06, 0x03, 
	0x07, 0x00, 0x07, 0x00, 0x06, 0x07, 0x07, 0x07, 
	0x07, 0x05, 0x06, 0x01, 0x01, 0x06, 0x03, 0x01, 
	0x09, 0x0a, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0c, 0x0b, 0x0b, 
	0x0b, 0x0d, 0x0b, 0x0d, 0x0c, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0e, 0x0b, 0x0c, 0x0b, 0x0b, 0x0c, 0x01, 
	0x0b, 0x0f, 0x07, 0x07, 0x07, 0x05, 0x07, 0x07, 
	0x05, 0x07, 0x02, 0x05, 0x06, 0x01, 0x07, 0x06, 
	0x07, 0x01, 0x07, 0x07, 0x05, 0x07, 0x0e, 0x0b, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x05, 
	0x10, 0x0a, 0x11, 0x0b, 0x0b, 0x0b, 0x0e, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0c, 0x0c, 
	0x0b, 0x12, 0x0b, 0x0b, 0x0b, 0x0b, 0x13, 0x13, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0d, 0x05, 
	0x09, 0x0f, 0x0d, 0x07, 0x07, 0x07, 0x05, 0x07, 
	0x07, 0x07, 0x07, 0x06, 0x00, 0x07, 0x01, 0x01, 
	0x0f, 0x07, 0x05, 0x07, 0x07, 0x07, 0x0c, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x05, 0x03, 0x03, 
	0x14, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0a, 0x0b, 0x0e, 0x0b, 0x0b, 0x0b, 0x09, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x15, 0x03, 
	0x10, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x0f, 0x00, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x06, 0x07, 0x07, 0x07, 0x07, 0x05, 0x01, 0x02, 
	0x16, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x17, 
	0x10, 0x18, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0c, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x12, 0x02, 
	0x09, 0x07, 0x07, 0x07, 0x07, 0x07, 0x0f, 0x0d, 
	0x0b, 0x0e, 0x07, 0x07, 0x07, 0x07, 0x12, 0x15, 
	0x07, 0x06, 0x05, 0x07, 0x07, 0x15, 0x07, 0x07, 
	0x07, 0x06, 0x05, 0x06, 0x07, 0x01, 0x04, 0x03, 
	0x19, 0x17, 0x0b, 0x0b, 0x0d, 0x0b, 0x10, 0x10, 
	0x10, 0x09, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0e, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0c, 0x0b, 0x0b, 0x0b, 0x12, 0x07, 0x03, 
	0x10, 0x0d, 0x07, 0x07, 0x00, 0x07, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x12, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x05, 0x03, 0x06, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x06, 0x00, 0x03, 0x04, 0x03, 0x01, 0x03, 
	0x10, 0x0b, 0x0b, 0x0b, 0x0b, 0x17, 0x10, 0x10, 
	0x10, 0x10, 0x09, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0d, 0x0c, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x07, 0x12, 0x03, 
	0x17, 0x07, 0x07, 0x07, 0x07, 0x15, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x07, 0x07, 0x07, 0x07, 
	0x00, 0x01, 0x03, 0x07, 0x04, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x00, 0x04, 0x00, 0x03, 0x02, 
	0x10, 0x0b, 0x0b, 0x0b, 0x17, 0x10, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x09, 0x10, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0d, 0x0b, 0x0d, 0x15, 0x02, 
	0x13, 0x0f, 0x07, 0x07, 0x0c, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 0x07, 0x07, 
	0x07, 0x06, 0x03, 0x03, 0x05, 0x07, 0x01, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x05, 0x04, 0x03, 
	0x1a, 0x10, 0x10, 0x11, 0x09, 0x18, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x11, 0x10, 0x10, 0x11, 
	0x0b, 0x0b, 0x15, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x0b, 0x03, 
	0x10, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0d, 
	0x12, 0x07, 0x06, 0x04, 0x07, 0x05, 0x04, 0x07, 
	0x07, 0x07, 0x07, 0x15, 0x15, 0x07, 0x00, 0x03, 
	0x1b, 0x1a, 0x10, 0x18, 0x0b, 0x0b, 0x13, 0x18, 
	0x0a, 0x10, 0x10, 0x18, 0x10, 0x10, 0x10, 0x10, 
	0x13, 0x0b, 0x0c, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x17, 0x0b, 0x0b, 0x0b, 0x03, 
	0x1c, 0x09, 0x0b, 0x0e, 0x0f, 0x12, 0x0e, 0x0e, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0e, 0x07, 0x07, 0x07, 0x05, 0x05, 0x07, 
	0x07, 0x07, 0x07, 0x0c, 0x0f, 0x07, 0x06, 0x01, 
	0x1d, 0x10, 0x10, 0x11, 0x13, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x09, 0x18, 0x18, 0x10, 0x10, 0x10, 
	0x10, 0x18, 0x0b, 0x0b, 0x0b, 0x0e, 0x0e, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x17, 0x0a, 0x0b, 0x0c, 0x01, 
	0x1a, 0x0b, 0x0b, 0x0d, 0x12, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x0b, 0x0e, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x13, 0x0b, 0x12, 0x0e, 0x12, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x12, 0x0b, 0x0b, 0x07, 0x06, 0x03, 
	0x14, 0x10, 0x11, 0x10, 0x17, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0a, 0x18, 0x10, 0x10, 
	0x10, 0x10, 0x13, 0x0a, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x13, 0x09, 0x10, 0x0b, 0x0b, 0x03, 
	0x10, 0x0b, 0x0b, 0x0b, 0x15, 0x07, 0x0f, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x0f, 0x0b, 0x0b, 0x18, 
	0x0a, 0x0b, 0x0b, 0x0b, 0x0e, 0x07, 0x07, 0x07, 
	0x07, 0x12, 0x0b, 0x0b, 0x0b, 0x0d, 0x07, 0x02, 
	0x1e, 0x10, 0x10, 0x10, 0x10, 0x10, 0x11, 0x0b, 
	0x0b, 0x0b, 0x17, 0x18, 0x10, 0x10, 0x09, 0x10, 
	0x10, 0x10, 0x18, 0x10, 0x18, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x13, 0x18, 0x09, 0x10, 0x11, 0x0b, 0x02, 
	0x10, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0d, 0x07, 
	0x07, 0x07, 0x0d, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x15, 0x07, 0x07, 
	0x07, 0x0b, 0x0b, 0x0b, 0x0a, 0x0b, 0x0d, 0x04, 
	0x1f, 0x10, 0x1a, 0x14, 0x14, 0x1a, 0x10, 0x13, 
	0x0b, 0x09, 0x09, 0x10, 0x10, 0x10, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x10, 0x17, 0x0b, 0x0b, 
	0x0b, 0x0a, 0x10, 0x10, 0x10, 0x10, 0x11, 0x04, 
	0x19, 0x18, 0x09, 0x10, 0x10, 0x09, 0x0b, 0x12, 
	0x07, 0x0c, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x09, 0x10, 0x0b, 0x0b, 0x12, 
	0x0b, 0x0b, 0x0a, 0x10, 0x10, 0x11, 0x0b, 0x03, 
	0x20, 0x1c, 0x14, 0x1d, 0x21, 0x14, 0x10, 0x10, 
	0x10, 0x09, 0x10, 0x10, 0x1a, 0x10, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x22, 0x10, 0x18, 0x13, 
	0x10, 0x10, 0x10, 0x1a, 0x14, 0x22, 0x11, 0x03, 
	0x1d, 0x10, 0x1c, 0x22, 0x14, 0x10, 0x10, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x11, 0x10, 0x0b, 0x18, 0x13, 
	0x10, 0x13, 0x11, 0x10, 0x10, 0x10, 0x0b, 0x0b, 
	0x0b, 0x17, 0x09, 0x10, 0x10, 0x10, 0x0b, 0x04, 
	0x21, 0x21, 0x23, 0x1d, 0x21, 0x14, 0x19, 0x14, 
	0x19, 0x10, 0x10, 0x10, 0x22, 0x16, 0x1f, 0x1f, 
	0x1e, 0x1c, 0x22, 0x16, 0x1e, 0x14, 0x10, 0x10, 
	0x10, 0x10, 0x1a, 0x14, 0x14, 0x16, 0x10, 0x04, 
	0x21, 0x1b, 0x14, 0x14, 0x14, 0x19, 0x10, 0x10, 
	0x10, 0x18, 0x0a, 0x11, 0x10, 0x10, 0x19, 0x19, 
	0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 
	0x01, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x04, 0x0b, 0x15, 0x05, 0x02, 0x02, 0x02, 0x02, 
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x01, 
	0x04, 0x10, 0x0b, 0x0e, 0x07, 0x07, 0x03, 0x07, 
	0x07, 0x0f, 0x07, 0x07, 0x07, 0x07, 0x07, 0x06, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x00, 0x07, 0x07, 0x07, 0x12, 
	0x02, 0x10, 0x07, 0x07, 0x07, 0x07, 0x07, 0x02, 
	0x03, 0x07, 0x07, 0x07, 0x07, 0x07, 0x05, 0x00, 
	0x07, 0x07, 0x07, 0x07, 0x06, 0x07, 0x07, 0x0b, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x02, 0x14, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x07, 
	0x07, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x0e, 0x0f, 
	0x0f, 0x0f, 0x07, 0x0b, 0x0c, 0x0c, 0x0b, 0x11, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0d, 0x0d, 
	0x02, 0x10, 0x12, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x12, 0x07, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x0c, 0x0b, 
	0x0f, 0x07, 0x07, 0x07, 0x0b, 0x07, 0x04, 0x02, 
	0x02, 0x1e, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0c, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0e, 0x13, 0x11, 
	0x0a, 0x0b, 0x0b, 0x0b, 0x10, 0x0b, 0x0f, 0x07, 
	0x02, 0x0b, 0x07, 0x07, 0x07, 0x07, 0x15, 0x15, 
	0x0b, 0x0b, 0x0b, 0x0e, 0x07, 0x07, 0x0e, 0x15, 
	0x0c, 0x15, 0x07, 0x07, 0x07, 0x0e, 0x07, 0x0b, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x02, 0x02, 
	0x02, 0x10, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x10, 0x18, 0x18, 0x0b, 0x0b, 0x0b, 0x0a, 0x0b, 
	0x13, 0x0b, 0x0b, 0x0b, 0x0b, 0x13, 0x0b, 0x0a, 
	0x0b, 0x0c, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 0x07, 
	0x01, 0x0b, 0x07, 0x07, 0x07, 0x07, 0x07, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0e, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x06, 0x07, 0x07, 0x0b, 0x0f, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x01, 0x02, 0x00, 
	0x01, 0x10, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x09, 
	0x10, 0x10, 0x10, 0x13, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x15, 0x0b, 0x0b, 0x10, 0x0b, 
	0x0b, 0x0d, 0x0d, 0x0d, 0x0b, 0x12, 0x07, 0x07, 
	0x02, 0x0f, 0x07, 0x07, 0x07, 0x07, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0c, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x05, 0x02, 0x07, 0x15, 0x0b, 0x15, 
	0x07, 0x07, 0x07, 0x07, 0x05, 0x02, 0x02, 0x02, 
	0x02, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x11, 0x10, 
	0x10, 0x10, 0x10, 0x11, 0x13, 0x0b, 0x0b, 0x0b, 
	0x0d, 0x0b, 0x0f, 0x07, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0e, 0x0e, 0x07, 0x07, 0x0d, 
	0x03, 0x0c, 0x0b, 0x07, 0x07, 0x0d, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 
	0x07, 0x07, 0x07, 0x04, 0x07, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x01, 0x02, 0x03, 
	0x03, 0x17, 0x11, 0x0b, 0x0b, 0x0b, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x10, 0x18, 0x11, 0x0b, 
	0x0b, 0x0d, 0x0e, 0x0f, 0x0d, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x12, 0x07, 0x15, 
	0x01, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0f, 0x04, 0x03, 0x02, 0x07, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x03, 0x07, 
	0x01, 0x10, 0x10, 0x10, 0x10, 0x11, 0x11, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 
	0x11, 0x0b, 0x07, 0x07, 0x07, 0x0b, 0x0e, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 0x0c, 
	0x02, 0x0b, 0x10, 0x0b, 0x0b, 0x07, 0x15, 0x07, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x07, 0x06, 0x03, 0x01, 0x05, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x0e, 0x07, 0x07, 0x07, 
	0x02, 0x10, 0x14, 0x10, 0x10, 0x0b, 0x0b, 0x0b, 
	0x13, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 
	0x10, 0x10, 0x0b, 0x12, 0x15, 0x12, 0x0e, 0x12, 
	0x0d, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0c, 
	0x04, 0x0b, 0x13, 0x0b, 0x0b, 0x0b, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x0b, 0x0b, 0x0b, 0x0b, 0x09, 
	0x10, 0x10, 0x0b, 0x15, 0x07, 0x07, 0x05, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x0b, 0x0d, 0x07, 0x07, 
	0x04, 0x10, 0x10, 0x10, 0x10, 0x0a, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x10, 0x10, 0x10, 0x10, 0x10, 
	0x14, 0x22, 0x10, 0x0b, 0x0b, 0x0b, 0x0e, 0x0d, 
	0x0c, 0x0b, 0x0b, 0x0b, 0x10, 0x11, 0x0b, 0x0e, 
	0x00, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 
	0x07, 0x07, 0x07, 0x0f, 0x07, 0x0d, 0x0b, 0x0b, 
	0x10, 0x10, 0x13, 0x0b, 0x0b, 0x0f, 0x07, 0x07, 
	0x07, 0x07, 0x07, 0x07, 0x0b, 0x0b, 0x07, 0x07, 
	0x00, 0x10, 0x10, 0x10, 0x10, 0x10, 0x13, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0a, 0x0b, 0x0a, 0x10, 0x10, 
	0x1a, 0x1e, 0x10, 0x10, 0x10, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x11, 0x10, 0x0b, 0x0c, 
	0x07, 0x0b, 0x0b, 0x0b, 0x0b, 0x13, 0x0b, 0x0b, 
	0x07, 0x07, 0x07, 0x07, 0x07, 0x0b, 0x0b, 0x0b, 
	0x0b, 0x0a, 0x0b, 0x0b, 0x0b, 0x0b, 0x15, 0x07, 
	0x07, 0x07, 0x07, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 
	0x07, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x11, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x10, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x10, 0x11, 0x0b, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x09, 0x10, 0x10, 0x10, 0x0b, 
	0x01, 0x17, 0x10, 0x10, 0x10, 0x10, 0x10, 0x0b, 
	0x0c, 0x0c, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 
	0x13, 0x18, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x07, 
	0x07, 0x12, 0x0b, 0x0b, 0x0b, 0x0a, 0x0b, 0x0b, 
	0x01, 0x10, 0x14, 0x14, 0x14, 0x1b, 0x14, 0x10, 
	0x17, 0x17, 0x17, 0x17, 0x10, 0x10, 0x10, 0x10, 
	0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x0b, 
	0x0b, 0x0b, 0x18, 0x10, 0x10, 0x10, 0x10, 0x0a, 
	0x00, 0x10, 0x19, 0x14, 0x14, 0x14, 0x1a, 0x10, 
	0x0b, 0x0b, 0x0b, 0x0b, 0x0a, 0x10, 0x10, 0x10, 
	0x10, 0x09, 0x0a, 0x10, 0x10, 0x10, 0x09, 0x0b, 
	0x0b, 0x0b, 0x0b, 0x0a, 0x10, 0x10, 0x10, 0x0b, 
	0x00, 0x14, 0x24, 0x21, 0x21, 0x21, 0x21, 0x1a, 
	0x10, 0x10, 0x10, 0x10, 0x19, 0x14, 0x19, 0x1e, 
	0x14, 0x1c, 0x10, 0x1a, 0x14, 0x14, 0x10, 0x09, 
	0x09, 0x09, 0x10, 0x10, 0x19, 0x14, 0x1e, 0x10, 
	0x05, 0x10, 0x14, 0x24, 0x21, 0x1d, 0x14, 0x1c, 
	0x10, 0x10, 0x10, 0x11, 0x10, 0x10, 0x10, 0x22, 
	0x14, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 
	0x10, 0x0a, 0x0b, 0x10, 0x10, 0x10, 0x10, 0x17, 
	0x05, 0x14, 0x21, 0x21, 0x25, 0x21, 0x21, 0x21, 
	0x14, 0x14, 0x14, 0x19, 0x14, 0x14, 0x14, 0x21, 
	0x21, 0x14, 0x14, 0x14, 0x14, 0x1b, 0x14, 0x22, 
	0x10, 0x10, 0x10, 0x14, 0x14, 0x14, 0x14, 0x10, 
	
};

Gfx stonewall_dark_bricks_pal_rgba16_aligner[] = {gsSPEndDisplayList()};
u8 stonewall_dark_bricks_pal_rgba16[] = {
	0x52, 0x97, 0x5a, 0xd5, 0x5a, 0xd7, 0x5a, 0x97, 
	0x52, 0xd7, 0x52, 0xd5, 0x5a, 0x95, 0x52, 0x95, 
	0x5a, 0x93, 0x4a, 0x11, 0x42, 0x53, 0x4a, 0x53, 
	0x52, 0x53, 0x4a, 0x55, 0x4a, 0x93, 0x4a, 0x95, 
	0x42, 0x11, 0x42, 0x13, 0x52, 0x93, 0x4a, 0x51, 
	0x39, 0xcf, 0x52, 0x55, 0x41, 0xcf, 0x4a, 0x13, 
	0x42, 0x51, 0x3a, 0x11, 0x41, 0xd1, 0x39, 0xcd, 
	0x42, 0x0f, 0x39, 0x8f, 0x3a, 0x0f, 0x31, 0xcf, 
	0x31, 0x8f, 0x31, 0x8d, 0x39, 0xd1, 0x39, 0x8d, 
	0x31, 0xcd, 0x29, 0x4b, 
};

Vtx stonewall_Cube_001_mesh_layer_1_vtx_0[16] = {
	{{ {-100, -46, 2076}, 0, {8517, 1694}, {129, 0, 0, 255} }},
	{{ {-100, 46, 2076}, 0, {8517, 1182}, {129, 0, 0, 255} }},
	{{ {-100, 46, -2076}, 0, {-8549, 1182}, {129, 0, 0, 255} }},
	{{ {-100, -46, -2076}, 0, {-8549, 1694}, {129, 0, 0, 255} }},
	{{ {-100, -46, -2076}, 0, {368, 752}, {0, 0, 129, 255} }},
	{{ {-100, 46, -2076}, 0, {624, 752}, {0, 0, 129, 255} }},
	{{ {100, 46, -2076}, 0, {624, 496}, {0, 0, 129, 255} }},
	{{ {100, -46, -2076}, 0, {368, 496}, {0, 0, 129, 255} }},
	{{ {100, -46, -2076}, 0, {8517, 1694}, {127, 0, 0, 255} }},
	{{ {100, 46, -2076}, 0, {8517, 1182}, {127, 0, 0, 255} }},
	{{ {100, 46, 2076}, 0, {-8549, 1182}, {127, 0, 0, 255} }},
	{{ {100, -46, 2076}, 0, {-8549, 1694}, {127, 0, 0, 255} }},
	{{ {100, -46, 2076}, 0, {368, 240}, {0, 0, 127, 255} }},
	{{ {100, 46, 2076}, 0, {624, 240}, {0, 0, 127, 255} }},
	{{ {-100, 46, 2076}, 0, {624, -16}, {0, 0, 127, 255} }},
	{{ {-100, -46, 2076}, 0, {368, -16}, {0, 0, 127, 255} }},
};

Gfx stonewall_Cube_001_mesh_layer_1_tri_0[] = {
	gsSPVertex(stonewall_Cube_001_mesh_layer_1_vtx_0 + 0, 16, 0),
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

Vtx stonewall_Cube_001_mesh_layer_1_vtx_1[8] = {
	{{ {-100, -46, -2076}, 0, {-11394, 496}, {0, 129, 0, 255} }},
	{{ {100, -46, -2076}, 0, {-11394, 1520}, {0, 129, 0, 255} }},
	{{ {100, -46, 2076}, 0, {11362, 1520}, {0, 129, 0, 255} }},
	{{ {-100, -46, 2076}, 0, {11362, 496}, {0, 129, 0, 255} }},
	{{ {100, 46, -2076}, 0, {11362, 1520}, {0, 127, 0, 255} }},
	{{ {-100, 46, -2076}, 0, {11362, 496}, {0, 127, 0, 255} }},
	{{ {-100, 46, 2076}, 0, {-11394, 496}, {0, 127, 0, 255} }},
	{{ {100, 46, 2076}, 0, {-11394, 1520}, {0, 127, 0, 255} }},
};

Gfx stonewall_Cube_001_mesh_layer_1_tri_1[] = {
	gsSPVertex(stonewall_Cube_001_mesh_layer_1_vtx_1 + 0, 8, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(0, 2, 3, 0),
	gsSP1Triangle(4, 5, 6, 0),
	gsSP1Triangle(4, 6, 7, 0),
	gsSPEndDisplayList(),
};


Gfx mat_stonewall_f3dlite_material_062[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(stonewall_f3dlite_material_062_lights),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, stonewall_dark_stars_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 40),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, stonewall_dark_stars_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_stonewall_f3dlite_material_062[] = {
	gsDPPipeSync(),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_stonewall_f3dlite_material[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPSetLights1(stonewall_f3dlite_material_lights),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, stonewall_dark_bricks_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 37),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, stonewall_dark_bricks_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 8, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0),
	gsDPSetTileSize(0, 0, 0, 252, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_stonewall_f3dlite_material[] = {
	gsDPPipeSync(),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx stonewall_Cube_001_mesh_layer_1[] = {
	gsSPDisplayList(mat_stonewall_f3dlite_material_062),
	gsSPDisplayList(stonewall_Cube_001_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_stonewall_f3dlite_material_062),
	gsSPDisplayList(mat_stonewall_f3dlite_material),
	gsSPDisplayList(stonewall_Cube_001_mesh_layer_1_tri_1),
	gsSPDisplayList(mat_revert_stonewall_f3dlite_material),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

