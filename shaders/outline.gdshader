shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;

void vertex() {
	vec2 texture_size = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 margin_uv = outline_width / texture_size;
	vec2 dir = sign(VERTEX);

	VERTEX += dir * outline_width;
	UV += dir * margin_uv;
}

void fragment() {
	vec2 uv = UV;
	vec4 tex_color = vec4(0.0);

	if (uv.x >= 0.0 && uv.x <= 1.0 && uv.y >= 0.0 && uv.y <= 1.0) {
		tex_color = texture(TEXTURE, uv);
	}

	if (tex_color.a < 0.5) {
		vec2 texel = outline_width / (1.0 / TEXTURE_PIXEL_SIZE) * sin((TIME*3.0));
		float alpha = 0.0;

		for (int x = -1; x <= 1; x++) {
			for (int y = -1; y <= 1; y++) {
				if (x == 0 && y == 0) continue;
				vec2 sample_uv = uv + vec2(float(x), float(y)) * texel;
				if (sample_uv.x >= 0.0 && sample_uv.x <= 1.0 && sample_uv.y >= 0.0 && sample_uv.y <= 1.0) {
					alpha += texture(TEXTURE, sample_uv).a;
				}
			}
		}

		if (alpha > 0.0) {
			tex_color = outline_color;
		}
	}

	COLOR = tex_color;
}