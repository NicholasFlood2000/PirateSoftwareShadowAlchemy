shader_type canvas_item;

uniform float lod_value = 0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap; 

void fragment() {
    COLOR = vec4(1,0,0,1.0);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV, lod_value);
}