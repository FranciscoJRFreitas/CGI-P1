precision mediump float;

varying float fLeft;
varying float fTotal;

void main() {
  
  gl_FragColor = vec4(mod(fTotal - fLeft, 1.0), mod(fTotal - fLeft, 1.0), mod(fTotal - fLeft, 1.0), mod(fTotal - fLeft, 1.0));

}