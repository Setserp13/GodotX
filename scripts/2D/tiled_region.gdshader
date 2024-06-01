shader_type canvas_item;

#include "res://addons/GodotX/shaders/math.gdshaderinc"
uniform vec4 tint = vec4(1,1,1,1);
uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset = vec2(0.0, 0.0);
uniform vec4 region = vec4(0.0,0.0,1.0,1.0); //position, size

void fragment() {
	vec2 coo = transform_tex(UV, tiling, offset);
	coo = region.xy + coo * region.zw;
    COLOR = texture(TEXTURE, coo) * tint;
}