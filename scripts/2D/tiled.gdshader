shader_type canvas_item;

#include "res://addons/GodotX/shaders/math.gdshaderinc"

uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset = vec2(0.0, 0.0);
varying vec4 tint;

void vertex() {
	tint = COLOR;
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 tex_coords = transform_tex(UV, tiling, offset);
    COLOR = texture(TEXTURE, tex_coords) * tint;// * vec4(COLOR.rgb, 1.0);// * tint;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
