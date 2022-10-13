precision highp float;

const int MAX_PLANETS=10;

uniform float uRadius[MAX_PLANETS];
uniform vec2 uPosition[MAX_PLANETS];

const float G_CONSTANT = 0.0000000000667;
const float AVG_DENSITY = 5510.0;
const float DIST_SCALE = 6371000.0;
const float PI = 3.14159265358979;

// Vertex position in World Coordinates
attribute vec2 vPosition;

uniform vec2 uScale;

varying vec2 fPosition;

void main()
{
    gl_Position = vec4(vPosition, 0.0, 1.0);
    fPosition = vPosition * uScale;
    
}