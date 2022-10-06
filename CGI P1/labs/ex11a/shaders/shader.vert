attribute vec4 vPosStart;
attribute vec4 vPosEnd;
uniform float uT;

void main() 
{
    gl_Position = mix(vPosStart, vPosEnd, uT);
}
