precision highp float;

#define AA

uniform float width;
uniform float height;
vec2 resolution = vec2(width, height);

uniform float time;

void main(){

	float strength = 0.4;
	float t = time/6.0;

	vec3 col = vec3(0);
	vec2 fC = gl_FragCoord.xy;

	#ifdef AA
	for(int i = -1; i <= 1; i++) {
		for(int j = -1; j <= 1; j++) {

			fC = gl_FragCoord.xy+vec2(i,j)/3.0;

			#endif

			//Normalized pixel coordinates (from 0 to 1)
			vec2 pos = fC/resolution.xy;

			pos.y /= resolution.x/resolution.y;
			pos = 4.0*(vec2(0.5) - pos);

			for(float k = 1.0; k < 7.0; k+=1.0){
				pos.x += strength * sin(2.0*t+k*1.5 * pos.y)+t*0.5;
				pos.y += strength * cos(2.0*t+k*1.5 * pos.x);
			}

			//Time varying pixel colour
			col += 0.5 + 0.5*cos(time+pos.xyx+vec3(0,2,4));

			#ifdef AA
		}
	}

	col /= 9.0;
	#endif

  //Gamma
  col = pow(col, vec3(0.4545));

	//Fragment colour
	gl_FragColor = vec4(col,1.0);
}
