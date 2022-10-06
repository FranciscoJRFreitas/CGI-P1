import * as THREE from "../../libs/three.module.js";

function setup()
{
    const scene = new THREE.Scene();
    const camera = new THREE.OrthographicCamera(-1.0, 1.0, 1.0, -1.0, -1.0, 1.0);
    
    const canvas = document.getElementById("gl-canvas");
    const renderer = new THREE.WebGLRenderer( {canvas: canvas});
    
    const shape = new THREE.Shape();
    shape.moveTo(-0.5, -0.5);
    shape.lineTo(0.5, -0.5);
    shape.lineTo(0, 0.5);
    
    const geometry = new THREE.ShapeGeometry(shape);
    
    const material = new THREE.MeshBasicMaterial( { color: 0xff0000 } );
    const triangle = new THREE.Mesh( geometry, material );
    scene.add( triangle );
    
    camera.position.z = 0;
    
    const animate = function () {
        window.requestAnimationFrame( animate );
        renderer.render( scene, camera );
    };

    window.requestAnimationFrame(animate);
}

setup();
