precision highp float;

varying vec2 fPosition;

void main() {
    
    gl_FragColor = vec4(mod(fPosition.x, 1.0), mod(fPosition.y, 1.0), 1.0, 1.0);
}