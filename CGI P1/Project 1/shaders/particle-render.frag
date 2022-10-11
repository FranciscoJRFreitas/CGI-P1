precision highp float;

varying float fLeft;
varying float fTotal;

void main() {
  gl_FragColor = mix(vec4(0.0,0.0,0.0,1.0),vec4(0.99,0.75,0.55,0.5), (fTotal-fLeft)/fTotal);
}