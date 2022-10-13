precision highp float;

const int MAX_PLANETS = 10;
const float minLife = 2.0;
const float maxLife = 20.0;
const float G_CONSTANT = 0.0000000000667;
const float DIST_SCALE = 6371000.0;

/* Number of seconds (possibly fractional) that has passed since the last
   update step. */
uniform float uDeltaTime;
uniform vec2 mouseLocation;
uniform float beamAngle;
uniform float beamOpen;
uniform float uMass[MAX_PLANETS];
uniform vec2 uPosition[MAX_PLANETS];
uniform int uCounter;

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

vec2 net_force(vec2 vPosition) {
   vec2 gfSum = vec2(0.0);

   for(int i = 0; i < MAX_PLANETS; i++) {
      if(i >= uCounter)
         break;
      vec2 part_planet_vec = vec2(uPosition[i].x - vPosition.x, uPosition[i].y - vPosition.y);
      gfSum += normalize(part_planet_vec) * G_CONSTANT * uMass[i] / (pow(length(part_planet_vec)*DIST_SCALE, 2.0));
   }
   return gfSum;
}

void main() {

   /* Update parameters according to our simple rules.*/
   vPositionOut = vPosition + vVelocity * uDeltaTime; //p(t+h) = p(t) + v(t) * h 
   vAgeOut = vAge + uDeltaTime;
   vLifeOut = minLife + rand(vPosition) * (maxLife - minLife);

   vVelocityOut = vVelocity + net_force(vPosition) * uDeltaTime; // v(t+h) = v(t) + F(t)/m1 * h

   if (vAgeOut >= vLife) {
      vPositionOut = mouseLocation;
      vAgeOut = 0.0;
      vLifeOut = minLife + rand(vPosition) * (maxLife - minLife);
      vVelocityOut = vec2(0.1*cos(beamOpen + (2.0 * beamAngle * rand(vPosition))), 0.23*sin(beamOpen + (2.0 * beamAngle * rand(vPosition))));
   }

}