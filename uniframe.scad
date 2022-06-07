$fa = 1;
$fs = 0.4;

// version 0.0.2

function margin(b, d, m) = (b==false) ? d : d - (2*m) ;
function is_margin(b, m) = (b==false) ? 0 : m ;

module base(hole_size, rows, holes, w, x_left=0, x_right=0, m_end=false, m_side=false, 
    m_faces=false, m=0, verbose=false) {
    l = hole_size * (holes * 2) + hole_size;
    h = hole_size * (rows * 2);
    mgn_l = margin(m_end, l, m);
    mgn_h = margin(m_faces, h , m);
    mgn_w = margin(m_side, w, m);
    
    if (verbose == true) {
        // Printing dimensions. Could be usefull to capture used dimension.
        echo("Printing base dimensions:")
        echo("length: ", mgn_l)
        echo("heigth: ", mgn_h)
        echo("width: ", mgn_w);
    }

    difference() {
        cube([mgn_l, mgn_w, mgn_h]);
        
        for (a = [1:rows]) {
            for (h = [1:holes]) {
                translate([
                    (h*hole_size+h*hole_size-hole_size/2) - is_margin(m_end, m),
                    w+0.001,
                    (a*hole_size+a*hole_size-hole_size) - is_margin(m_faces, m)]) {
                    rotate([90,0,0]) {
                        cylinder(w+0.002,d=hole_size+0.25);
                    }
                }
            }
        }
    }
}

//base(3, 2, 5, 5, m_end=false, m_faces=false, m_side=false, m=0.1);