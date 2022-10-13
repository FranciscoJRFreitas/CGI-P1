precision highp float;

varying float fLeft;
varying float fTotal;

void main() {
  gl_FragColor = vec4(0.99,0.75,0.55,(fTotal-fLeft)/fTotal);
}