shader_type canvas_item;

uniform float move_speed = 0.5;

void fragment() {
    // Desloca a textura ao longo do tempo usando UV.x
    vec2 uv = vec2(UV.x + TIME * move_speed, UV.y);
    COLOR = texture(TEXTURE, uv);
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
