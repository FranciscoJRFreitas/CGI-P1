uniform float uDx;
attribute vec4 vPosition;

void main() 
{
    gl_Position = vPosition + vec4(uDx, 0.0, 0.0, 0.0);
}
