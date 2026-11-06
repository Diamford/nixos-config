
precision highp float;

varying vec2 v_coords;

uniform vec2 size;
uniform vec2 u_camera;
uniform float u_zoom;
uniform float u_time;

void main() {
	vec2 screen = v_coords * size;
	vec2 canvas = (screen + u_camera) /
		max(u_zoom, 0.01);

	vec2 uv = canvas * 0.001;

	float t = u_time * 0.15;

	vec3 color = vec3(0.012, 0.008, 0.035);

	// Animated neon waves
	float wave1 = sin(
		uv.x * 2.0 +
		sin(uv.y * 1.5 + t) +
		t
	);

	float wave2 = cos(
		uv.y * 2.5 -
		uv.x * 0.8 -
		t * 0.7
	);

	float glow1 = pow(
		0.5 + 0.5 * wave1,
		8.0
	);

	float glow2 = pow(
		0.5 + 0.5 * wave2,
		12.0
	);

	color += vec3(0.18, 0.01, 0.42)
		* glow1 * 0.65;

	color += vec3(0.0, 0.32, 0.55)
		* glow2 * 0.45;

	// Infinite neon grid
	vec2 grid = abs(fract(uv * 3.0) - 0.5);

	float line = min(grid.x, grid.y);

	float gridGlow = exp(-line * 75.0);

	float pulse = 0.65 +
		0.35 * sin(t * 2.0);

	color += vec3(0.0, 0.12, 0.25)
		* gridGlow * pulse;

	// Subtle breathing illumination
	float ambient = 0.5 +
		0.5 * sin(t + uv.x + uv.y);

	color += vec3(0.025, 0.0, 0.055)
		* ambient;

	gl_FragColor = vec4(color, 1.0);
}

