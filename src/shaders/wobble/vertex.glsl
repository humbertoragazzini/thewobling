attribute vec4 tangent;
#include ../includes/simplexNoise4d.glsl;


void main(){

  //tangent
  vec3 biTangent = cross(nomral,tangent.xyz)

  //neighbors
  float shift = 0.01;  
  vec3 positionA = csm_Position + tangent.xyz  * shift;
  vec3 positionB = csm_Position + biTangent.xyz  * shift;
  
  //wobble
  float wobble = simplexNoise4d(
        vec4(
          csm_Position,
          0.0
        )
      );
  csm_Position += wobble * normal;
}
