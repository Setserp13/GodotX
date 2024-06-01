shader_type canvas_item;

#include "res://addons/GodotX/shaders/math.gdshaderinc"

uniform vec2 tiling = vec2(1.0,1.0);
uniform vec2 size;
uniform vec4 margins; // Left, Top, Right, Bottom margins

void fragment() {
	vec2 tex_size = vec2(textureSize(TEXTURE, 0));

	float _u0 = margins.x / tex_size.x;
	float _u1 = 1.0 - margins.z / tex_size.x;
	float _x0 = margins.x / size.x;
	float _x1 = 1.0 - margins.z / size.x;
	
	vec2 uv = UV;
	vec2 tex_uv = uv;
	
	if(uv.x < _x0)
	{
		tex_uv.x *= _u0 / _x0;
		tex_uv.x = repeat(tex_uv.x, _u0);
	}
	else if(uv.x < _x1)
	{
		tex_uv.x -= _x0;
		tex_uv.x *= tiling.x;
		tex_uv.x = _u0 + repeat(tex_uv.x, _u1 - _u0);
	}
	else
	{
		tex_uv.x -= 1.0;
		tex_uv.x *= (1.0 - _u1) / (1.0 - _x1);
		tex_uv.x = _u1 + repeat(tex_uv.x, 1.0 - _u1);
	}
	
	float _v0 = margins.y / tex_size.y;
	float _v1 = 1.0 - margins.w / tex_size.y;
	float _y0 = margins.y / size.y;
	float _y1 = 1.0 - margins.w / size.y;
	if(uv.y < _y0)
	{
		tex_uv.y *= _v0 / _y0;
		tex_uv.y = repeat(tex_uv.y, _v0);
	}
	else if(uv.y < _y1)
	{
		tex_uv.y -= _y0;
		tex_uv.y *= tiling.y;
		tex_uv.y = _v0 + repeat(tex_uv.y, _v1 - _v0);
	}
	else
	{
		tex_uv.y -= 1.0;
		tex_uv.y *= (1.0 - _v1) / (1.0 - _y1);
		tex_uv.y = _v1 + repeat(tex_uv.y, 1.0 - _v1);
	}
    vec4 tex_color = texture(TEXTURE, tex_uv);
    COLOR = tex_color;
}