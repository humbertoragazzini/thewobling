
uniform float uTime;
uniform float uPositionFrecuency;
uniform float uTimeFrecuency;
uniform float uStrength;
uniform float uWarpPositionFrecuency;
uniform float uWarpTimeFrecuency;
uniform float uWarpStrength;
attribute vec4 tangent;
varying float vWobble;

#include ../includes/simplexNoise4d.glsl;

float getWobble(vec3 position){
  //WarpPosition
  vec3 warpedPosition = position;
  warpedPosition += simplexNoise4d(vec4(
        position*uWarpPositionFrecuency,
        uTime * uWarpTimeFrecuency
      ))*uWarpStrength;
  return simplexNoise4d(
        vec4(
          warpedPosition*uPositionFrecuency,
          uTime * uTimeFrecuency
        )
      )*uStrength;
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
  positionA += getWobble(positionA) * normal;
  positionB += getWobble(positionB) * normal; 

  //compute normalized
  vec3 toA = normalize(positionA-csm_Position);
  vec3 toB = normalize(positionB-csm_Position);
  csm_Normal = cross(toA,toB);
  vWobble = wobble;
}
