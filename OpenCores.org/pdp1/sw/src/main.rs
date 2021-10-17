#[macro_use]
extern crate glium;
extern crate rand;
extern crate time;

fn main() {
    use rand::Rng;
    let mut rng = rand::thread_rng();
    use glium::DisplayBuild;
    let builder = glium::glutin::WindowBuilder::new();
    let window = builder
        .with_dimensions(1024,1024)
        .with_title("GLscope")
        .with_vsync()
        .build_glium()
        .unwrap();
    let mut now: f32;

    // 2D vertex type for plot points
    #[derive(Copy, Clone, Debug)]
    struct Vertex {
        position: [f32; 2],
        time: f32  // Suggest using microseconds
    }
    implement_vertex!(Vertex, position, time);
    // Note: need to transform -1023..1023 to -1..1
    // Could extend PDP-1 display instruction to 18 bit
    
    // TODO: Set up OpenGL stuff to draw something
    //window.make_current().expect("Couldn't make context current");
    let mut frame = window.draw();
    use glium::Surface;
    // So far, so good. I can clear the image.
    // I can also plot points, using two shaders.
    // Those can be blended (additive in this case).
    // Time to extend the vertices with a timestamp for age?

    // Set up a random array of points
    /*
    let mut shape: Vec<Vertex> = Vec::new();
    for t in 0..20000 {
        shape.push(Vertex {
            position: [rng.next_f32()*2.0-1.0,
                       rng.next_f32()*2.0-1.0],
            time: t as f32 });
    }*/
    let vbmax = 20000;
    let mut vbindex = 0;
    // TODO: streaming suited vertexbuffer.
    // Docs say to use dynamic, persistent might be GL4?
    let mut vertex_buffer : glium::VertexBuffer<Vertex> =
        glium::VertexBuffer::empty_dynamic(&window, vbmax).unwrap();
    // Possible todo: add line support, perhaps modulated
    // by beam trace speed. 
    let indices = glium::index::NoIndices(
        glium::index::PrimitiveType::Points);

    let vertex_shader_src = r#"
        #version 140
        in vec2 position;
        in float time;
        out float age;
        uniform float now;
        void main() {
            age = now-time;
            if (age >= 0) {
                gl_Position = vec4(position, 0.0, 1.0);
            }
        }
    "#;

    // Should use a uniform to indicate current time
    // Possibly add a timestamp per lit dot?
    let fragment_shader_src = r#"
        #version 140
        in float age;
        out vec4 color;
        void main() {
            float intensity = 1e1*exp(-8e-6*age);
            color = vec4(intensity, intensity, intensity, 1.0);
        }
    "#;
    let program =
       glium::Program::from_source(&window,
                                   vertex_shader_src,
                                   fragment_shader_src,
                                   None).unwrap();
    let drawparams = glium::DrawParameters {
        blend: glium::Blend {
            color: glium::BlendingFunction::Addition {
                source: glium::LinearBlendingFactor::One,
                destination: glium::LinearBlendingFactor::One },
            .. Default::default() },
        .. Default::default()
    };

    let t0 = time::get_time();

    use std::sync::mpsc::{channel, Receiver};
    let verts : Receiver<Vertex> = {
        use std::thread::spawn;

        let (tx, rx) = channel();
        spawn(move || {
            loop {
                let mut str = String::new();
                std::io::stdin().read_line(&mut str).unwrap();
                let now = (time::get_time() - t0)
                    .num_microseconds().unwrap() as f32;
                // FIXME: Parse line.
                let mut words = str.split_whitespace();
                let x = words.next().unwrap().parse().unwrap();
                let y = words.next().unwrap().parse().unwrap();
                let v = Vertex {position: [x, y], time: now };
                tx.send(v).unwrap();
                //println!("Vertex: {:?}", v);
            }
        });
        rx
    };
    
    loop {
        for event in window.poll_events() {
            // Simplest nowait: use poll_events()
            match event {
                glium::glutin::Event::Closed => {
                    frame.finish().unwrap();
                    return;
                },
                _ => ()
            }
        }

        now = (time::get_time() - t0).num_microseconds().unwrap()
            as f32;

        // Inject new points
        {
            let mut wvb = vertex_buffer.map_write();
            // Add 21 random points per frame
            for _ in 0..20 {
                wvb.set(vbindex, Vertex {
                    position: [rng.next_f32()*2.0-1.0,
                               rng.next_f32()*2.0-1.0],
                    time: now });
                vbindex = (vbindex+1) % vbmax;
            }
            // TODO: Read points from e.g. stdin
            for v in verts.try_iter() {
                //println!("Vertex: {:?} {} {}",
                //         v.position, v.time, now);
                wvb.set(vbindex, v);
                vbindex = (vbindex+1) % vbmax;
            }
        }

        // Closing the window closes the program.
        frame.clear_color(0.0, 0.0, 0.0, 1.0);
        frame.draw(&vertex_buffer, &indices, &program,
                   //&glium::uniforms::EmptyUniforms,
                   &uniform! { now: now },
                   &drawparams).unwrap();
        
        window.swap_buffers().unwrap();
    }
}
