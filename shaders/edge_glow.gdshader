shader_type canvas_item;

uniform int index = 0;
uniform vec4 color_palette[5]: source_color;
uniform vec4 glow_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float glow_intensity : hint_range(0.0, 5.0) = 2.0;
uniform float glow_radius : hint_range(0.0, 50.0) = 5.0;

varying float modulate_alpha;

void vertex() {
    // In vertex(), COLOR contains the combined modulate and self_modulate data
    modulate_alpha = COLOR.a;
}

void fragment() {
    vec4 current_color = texture(TEXTURE, UV);
    vec2 size = TEXTURE_PIXEL_SIZE * glow_radius;
    float alpha = 0.0;

    // Sample surrounding pixels to find transparency edge
    for(float x = -1.0; x <= 1.0; x += 0.5) {
        for(float y = -1.0; y <= 1.0; y += 0.5) {
            vec2 offset = vec2(x, y) * size;
            alpha += texture(TEXTURE, UV + offset).a;
        }
    }

    // Smooth and blend the glow behind the original texture
    alpha = clamp(alpha / 9.0, 0.0, 1.0);
    vec4 final_glow = color_palette[index] * alpha * glow_intensity;
	vec4 mx = mix(final_glow, current_color, current_color.a);
    COLOR = mx * modulate_alpha;
}
