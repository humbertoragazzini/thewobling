#include ../includes/simplexNoise4d.glsl;


void main(){
  //wobble
  float wobble = simplexNoise4d(
        vec4(
          csm_Position,
          0.0
        )
      );
  csm_Position += wobble * normal;
}
