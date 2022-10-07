precision mediump float;

const int MAX_PLANETS=10;

uniform float uRadius[MAX_PLANETS];
uniform vec2 uPosition[MAX_PLANETS];

// Vertex position in World Coordinates
attribute vec2 vPosition;

uniform vec2 scale;

varying vec2 fPosition;

void main() 
{
    gl_Position = vec4(vPosition, 0.0, 1.0);
    fPosition = vPosition * scale;
}