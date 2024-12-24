attribute vec4 tangent;
#include ../includes/simplexNoise4d.glsl;

float getWobble(vec3 position){
  return simplexNoise4d(
        vec4(
          position,
          0.0
        )
      );
}

void main(){

  //tangent
  vec3 biTangent = cross(normal,tangent.xyz);

  //neighbors
  float shift = 0.01;  
  vec3 positionA = csm_Position + tangent.xyz  * shift;
  vec3 positionB = csm_Position + biTangent.xyz  * shift;
  
  //wobble
  float wobble = getWobble(csm_Position);
  csm_Position += wobble * normal;
}
