precision highp float;

const float minLife = 2.0;
const float maxLife = 20.0;

/* Number of seconds (possibly fractional) that has passed since the last
   update step. */
uniform float uDeltaTime;
uniform vec2 mouseLocation;
uniform float beamAngle;

/* Inputs. These reflect the state of a single particle before the update. */

attribute vec2 vPosition;              // actual position
attribute float vAge;                  // actual age (in seconds)
attribute float vLife;                 // when it is supposed to die
attribute vec2 vVelocity;              // actual speed

/* Outputs. These mirror the inputs. These values will be captured into our transform feedback buffer! */
varying vec2 vPositionOut;
varying float vAgeOut;
varying float vLifeOut;
varying vec2 vVelocityOut;


// generates a pseudo random number that is a function of the argument. The argument needs to be constantly changing from call to call to generate different results
highp float rand(vec2 co)
{
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt= dot(co.xy ,vec2(a,b));
    highp float sn= mod(dt,3.14);
    return fract(sin(sn) * c);
}

vec2 net_force(vPosition) {
   return vec2(0.0);
}

void main() {

   /* Update parameters according to our simple rules.*/
   vPositionOut = vPosition + vVelocity * uDeltaTime; //p(t+h) = p(t) + v(t) * h 
   vAgeOut = vAge + uDeltaTime;
   vLifeOut = minLife + rand(vPosition) * (maxLife - minLife);

   vVelocityOut = vVelocity + net_force(vPosition) * uDeltaTime;
      
   if (vAgeOut >= vLife) {
      vPositionOut = mouseLocation;
      vAgeOut = 0.0;
      
   }

}