varying vec2 vUv;
#include ../includes/simplexNoise4d.glsl


void main(){
  //wobble
  float wobble = simplexNoise4d(
        csm_Position,
        0.0
      );
  csm_Position+=wobble * normal;

}

