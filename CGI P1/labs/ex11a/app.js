import { loadShadersFromURLS, loadShadersFromScripts, setupWebGL, buildProgramFromSources } from "../../libs/utils.js";
import { vec2, flatten } from "../../libs/MV.js";

/** @type {WebGLRenderingContext} */
var gl;
var program;

const N_VERTICES = 100;
const SPEED = 0.01;

function setup(shaders)
{
    // Setup
    const canvas = document.getElementById("gl-canvas");
    gl = setupWebGL(canvas);

    program = buildProgramFromSources(gl, shaders["shader.vert"], shaders["shader.frag"]);

    const vertices = [];

    function generateRandomVertex()
    {
        var x = (Math.random() - 0.5)*2;
        var y = (Math.random() - 0.5)*2;
        return vec2(x, y);
    }

    function generateVertices(count)
    {
        let angle = 0;
        for(let i=0; i<count; i++) {
            // Generate start position
            vertices.push(generateRandomVertex());
            // Generate end position
            angle += 2*Math.PI/count;
            vertices.push(vec2(Math.cos(angle), Math.sin(angle)));
        }
    }

    generateVertices(N_VERTICES);


    const aBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, aBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, flatten(vertices), gl.STATIC_DRAW);

    const vPosStart = gl.getAttribLocation(program, "vPosStart");
    gl.vertexAttribPointer(vPosStart, 2, gl.FLOAT, false, 16, 0);
    gl.enableVertexAttribArray(vPosStart);

    const vPosEnd = gl.getAttribLocation(program, "vPosEnd");
    gl.vertexAttribPointer(vPosEnd, 2, gl.FLOAT, false, 16, 8);
    gl.enableVertexAttribArray(vPosEnd);

    // Setup the viewport
    gl.viewport(0, 0, canvas.width, canvas.height);

    // Setup the background color
    gl.clearColor(0.0, 0.0, 0.0, 1.0);

    // Call animate for the first time
    window.requestAnimationFrame(animate);
}

function animate(time)
{
    window.requestAnimationFrame(animate);

    // Drawing code
    gl.clear(gl.COLOR_BUFFER_BIT);

    gl.useProgram(program);
    
    const uT = gl.getUniformLocation(program, "uT");
    gl.uniform1f(uT, (1+Math.sin(time*0.001))/2);
    
   gl.drawArrays(gl.LINE_LOOP, 0, N_VERTICES);
}

loadShadersFromURLS(["shader.vert", "shader.frag"]).then(shaders => setup(shaders));
