float sin01(float x)
{
	return (1.0 + sin(x)) * 0.5;
}

float sin_clamp(float x, float _min, float _max)
{
	return _min + sin01(x) * (_max - _min);
}

float repeat(float t, float len)
{
    return t - floor(t / len) * len;
}

float ping_pong(float value, float len)
{
    return len - abs(repeat(value, 2.0 * len) - len);
}

vec2 clamp2(vec2 uv, vec2 _min, vec2 _max)
{
	return vec2(clamp(uv.x, _min.x, _max.x), clamp(uv.y, _min.y, _max.y));
}

vec2 repeat2(vec2 uv, vec2 len)
{
	return vec2(repeat(uv.x, len.x), repeat(uv.y, len.y));
}

vec2 ping_pong2(vec2 uv, vec2 len)
{
	return vec2(ping_pong(uv.x, len.x), ping_pong(uv.y, len.y));
}

vec2 transform_uv(vec2 uv, vec2 tiling, vec2 offset, int mode) //0 = clamp, 1 = repeat, 2 = ping_pong
{
	uv = uv * tiling - offset;
	if (mode == 0)
	{
		return clamp2(uv, vec2(0.0,0.0), vec2(1.0,1.0));
	}
	else if(mode == 1)
	{
		return fract(uv);
	}
	else
	{
		return ping_pong2(uv, vec2(1.0,1.0));
	}
}

vec2 inv_transform_uv(vec2 uv, vec2 tiling, vec2 offset)
{
	return (uv + offset) / tiling;
}

vec4 sprite_mask_2D(sampler2D tex, vec2 uv, vec2 tiling, vec2 offset, int mode)
{
	//uv = transform_tex(uv, _tiling, _offset);
    vec4 c = texture(tex, uv);
    // The block below only applies TRANSFORM_TEX to non-transparent pixels
	if(c.a > 0.5) {//0.1) { //0.1 cuz background is not all transparent, that's need
		uv = transform_uv(uv, tiling, offset, mode);//uv - offset;
		c = texture(tex, uv);
		if(c.a < 1.0) { c.a = 1.0; }
	}
	else { c.a = 0.0; }
	return c;
}










vec2 transform_tex(vec2 uv, vec2 tiling, vec2 offset) //REMOVE THIS LATER
{
	uv = uv * tiling - offset;
    return fract(uv);
}

vec4 sprite_mask_tex2D(sampler2D tex, vec2 uv, vec2 _tiling, vec2 _offset)
{
	
	//uv = transform_tex(uv, _tiling, _offset);
    vec4 c = texture(tex, uv);
    // The block below only applies TRANSFORM_TEX to non-transparent pixels
	if(c.a > 0.5) {//0.1) { //0.1 cuz background is not all transparent, that's need
		uv = transform_tex(uv, _tiling, _offset);//uv - offset;
		c = texture(tex, uv);
		if(c.a < 1.0) { c.a = 1.0; }
	}
	else { c.a = 0.0; }
	return c;
}