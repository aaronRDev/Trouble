shader_type canvas_item;

uniform vec3 inner_circle_colour : source_color = vec3(1.0);
uniform vec3 internal_ring_colour : source_color = vec3(1.0);

uniform float internal_ring_width : hint_range(0.0,1.0) = 0.0f; // How far into the rendered part of the circle we should render our coloured circle.

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, UV);	
	
	vec2 textureSize = TEXTURE_PIXEL_SIZE; // size of the texture that we have to draw our internal ring on. 
	float smooth_step_ratio = textureSize.y/6.0;
	
	vec2 internalRingUV = (UV.xy - textureSize.xy * 0.5f) / min(textureSize.x, textureSize.y) * 2.0f;
	float distanceFromMarchedUV = length(internalRingUV) - 0.5f;
	float ret = smoothstep(0.0, 0.0, distanceFromMarchedUV);
	COLOR.rgb = ret == 1.0f ? internal_ring_colour.rgb * ret : inner_circle_colour.rgb;
	COLOR.rgba *= smoothstep(internal_ring_width + smooth_step_ratio, smooth_step_ratio, distanceFromMarchedUV);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
