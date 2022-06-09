$fa = 1;
$fs = 0.4;

// version 0.0.2

function margin(b, d, m) = (b==false) ? d : d - (2*m) ;
function is_margin(b, m) = (b==false) ? 0 : m ;
function border(b, d) = (b==0) ? d : b ;

module u_rectangle(hole_size, cols, holes, w, mx=false, my=false, 
    mz=false, bx=0, by=0, m=0, hm=0.25, verbose=false) {
    bx = border(bx, hole_size/2);
    by = border(by, hole_size/2);
    l = hole_size * (holes * 2) - hole_size + bx * 2;
    h = hole_size * (cols * 2) - hole_size + by * 2;
    mgn_l = margin(mx, l, m);
    mgn_h = margin(mz, h , m);
    mgn_w = margin(my, w, m);
    
    if (verbose == true) {
        // Printing dimensions. Could be usefull to capture used dimension.
        echo("Printing base dimensions:")
        echo("length: ", mgn_l)
        echo("heigth: ", mgn_h)
        echo("width: ", mgn_w)
        echo("hole_size: ", hole_size+hm)
        echo("X border size: ", bx)
        echo("Y border size: ", by);
    }

    difference() {
        cube([mgn_l, mgn_w, mgn_h]);
        
        for (a = [1:cols]) {
            for (h = [1:holes]) {
                translate([
                    ((h*hole_size + h*hole_size) - hole_size*1.5 + bx) - is_margin(mx, m),
                    w+0.001,
                    ((a*hole_size + a*hole_size) - hole_size*1.5 + by) - is_margin(mz, m)
                    ]) {
                    rotate([90,0,0]) {
                        cylinder(w+0.002,d=hole_size+hm);
                    }
                }
            }
        }
    }
}
