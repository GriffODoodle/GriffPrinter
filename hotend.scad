//testing
//e3d_holder_shroud();
//translate ([-40,0,0]) E3dHolder_Shroud_old();

hotendShroud();

module hotendShroud() {

    E3dHolder();
    translate ([30,36,0]) rotate([0,0,180]) e3d_holder_shroud();
    translate ([30,3,-25]) {
        blower_fan_cooling (flatHeight = 1, squeezeHeight = 10, out_length=7, blower_nozzle_gap = 18, output_angle=-10);
    }
    %translate ([15,20.5,10.5]) rotate ([0,0,90]) E3DHotend (); //From thing 80904
}

module E3dHolder (color) {
    color(color) {
        rotate ([-90,0,0]) {
            translate ([0,-10,0]) difference () { //A frame
                union () {
                    hull () {
                        translate ([30,-30,0]) cylinder (r=5,h=3);
                        translate ([15,10,0]) cylinder (r=5,h=3);
                    }
                    hull () {
                        translate ([00,-30,0]) cylinder (r=5,h=3);
                        translate ([15,10,0]) cylinder (r=5,h=3);
                    }
                }
                translate ([30,-30,-1]) cylinder (r=3,h=6);//holes 
                translate ([0,-30,-1]) cylinder (r=3,h=6);//holes 
                translate ([15,10,-1]) cylinder (r=3,h=6);//holes 
            }
            translate ([28,-30,7]) rotate ([0,90,0]) {
                difference () {//5015 holder
                    hull(){
                        cylinder(r=4,h=2);
                        translate([-4,4,0]) cube([8,8,2]);
                        translate ([1,-4,0]) cube ([6,10,2]);
                    }
                    translate ([0,0,-1])cylinder(r=2.25,h=4);
                }
                //holey part of the 5015 from blower_50mm.scad
                %translate ([-21.75,20,12.5]) blower_50mm();
            }
        }
        difference () {//main box
            translate ([0,0,15.1]) cube ([30,20,9.8]);
            translate ([15,20,15]) {
                union () {//top of E3d to be held
                    cylinder(d=4.2, h=46);
                    cylinder(d=12.2, h=8);
                    translate([0,0,8 - 4.1]) cylinder(d=17, h= 4.1);    
                    translate([0,0,7.99]) cylinder(d=12.2, h=2);
                }
            }
            //bolt holes to hold types
            translate ([4,21,20]) rotate ([90,0,0]) cylinder (r=1.6,h=22);
            translate ([26,21,20]) rotate ([90,0,0]) cylinder (r=1.6,h=22);
        }
    }
}

module e3d_holder_shroud (color) {
    color(color) {
        difference () {//main box
            translate ([0,0,15.1-34]) cube ([30,15,9.8+34]);
            translate ([15,15,15]) {
                union () {//top of E3d to be held
                    cylinder(d=4.2, h=46);
                    cylinder(d=12.2, h=8);
                    translate([0,0,8 - 4.1]) cylinder(d=17, h= 4.1);    
                    translate([0,0,7.99]) cylinder(d=12.2, h=2);
                }
            }
            //bolt holes to hold to hotend back plate
            translate ([4,16,20]) rotate ([90,0,0]) cylinder (r=2,h=22);
            translate ([26,16,20]) rotate ([90,0,0]) cylinder (r=2,h=22);
            //cooling cylinder
            translate ([15,15,15.1-42-1]) cylinder(r=12.5,h=42+1);
            //Hotend Cooling Fan Holes
            translate ([15,3,-4]) rotate ([90,0,0])for (i=[0:3])
            {
                rotate([0,0,i*90])
                {
                    translate([12, 12])
                    {
                        cylinder(r=2.25, h=8, center=true);
                    }
                }
            }
            //Hotend Cooling Fan Gap
            translate ([15,15,-4]) rotate ([90,0,0]) cylinder (r=12.5,h=15+1);

        }
    }
}
module E3dHolder_Shroud_old (color) {
    color(color) {
        difference () {//main box
            translate ([0,0,15.1-42]) cube ([30,15,9.8+42]);
            translate ([15,15,15]) {
                union () {//top of E3d to be held
                    cylinder(d=4.2, h=46);
                    cylinder(d=12.2, h=8);
                    translate([0,0,8 - 4.1]) cylinder(d=17, h= 4.1);    
                    translate([0,0,7.99]) cylinder(d=12.2, h=2);
                }
            }
            //bolt holes to hold types
            translate ([4,16,20]) rotate ([90,0,0]) cylinder (r=2,h=22);
            translate ([26,16,20]) rotate ([90,0,0]) cylinder (r=2,h=22);
            //cooling cylinder
            translate ([15,15,15.1-42-1]) cylinder(r=12.5,h=42+1);
            //Hotend Cooling Fan Holes
            translate ([15,3,-10]) rotate ([90,0,0])for (i=[0:3])
            {
                rotate([0,0,i*90])
                {
                    translate([12, 12])
                    {
                        cylinder(r=1.15, h=7, center=true);
                    }
                }
            }
            //Hotend Cooling Fan Gap
            translate ([15,15,-10]) rotate ([90,0,0]) cylinder (r=12.5,h=15+1);

        }
    }
}



module universal_fan_duct_outflow(blower_nozzle_gap = 20, ring_height = ring_height, head_gap = head_gap, carve = false) {
    ri = 7;
    ro = ri + wall_width*2 + 4;
    cut = ro * 2;
    
    angle = atan(head_gap / 2 / (blower_nozzle_gap + out_depth));
    vent_len = (blower_nozzle_gap + out_depth) / cos(angle);
    vent_width = out_depth*sqrt(3) + wall_width*2;

    difference() {
        rotate([0, 0, -angle]) {
            // Exit ducting & fan mount
            
            // Connector to nozzle
            translate([ri+wall_width, -vent_width/2, 0]) {
                if (!carve) {
                  cube([vent_len - ri - wall_width, vent_width, ring_height]);
                } else {
                  translate([-0.1, wall_width, wall_width])
                        cube([vent_len - ri + 0.2, (vent_width-3*wall_width)/2, ring_height - wall_width*2]);
                  translate([-0.1, wall_width + (vent_width-2*wall_width + wall_width)/2, wall_width])
                        cube([vent_len - ri + 0.2, (vent_width-3*wall_width)/2, ring_height - wall_width*2]);
               }
            }
              
            universal_fan_duct_outlet(ro = ro, ri = ri, height = ring_height, carve = carve);
        }
        rotate([0, -19, 0]) if (!carve) {
            translate([-ro, -cut/2, wall_width - 0.1]) cube([ro*3, cut, ring_height*2 + 0.2]);
        } else {
            translate([-ro, -(cut+2)/2, -0.1]) cube([ro*3, cut + 2, ring_height*2 + 0.2]);
        }
    }
}

module universal_fan_duct_outlet(ro=15, ri=8, height = 4, carve = false) {
    rotate_extrude(convexity=4) {
        translate([ri, 0]) {
            if (!carve) {
                square([ro-ri, height]);
            } else {
                polygon([[wall_width, -0.1], [wall_width*2, -0.1], 
                         [ro-ri-wall_width, height*0.3], 
                         [ro-ri-wall_width, height-wall_width], 
                         [wall_width, height-wall_width]]);
            }
        }
    }
}

module universal_fan_duct_blower_adapter_fab(flatHeight=7, squeezeHeight = 15, size = blower_out, carve = false, out_length=10) {
    if (!carve) {
       translate([wall_width, wall_width, 0])
            cube([size[0], size[1], flatHeight+size[2]]);
        hull() {
            cube([size[0]+2*wall_width, size[1]+wall_width, flatHeight]);
            translate([size[0]/2 + wall_width, size[1]/2, 0]) rotate([180, 0, 0]) cylinder(r = out_depth + wall_width - tolerance, h = squeezeHeight, $fn = 60);
        }
        translate([size[0]/2 + wall_width, size[1]/2, 0])
            rotate([180, 0, 0]) cylinder(r = out_depth + wall_width - tolerance, h = squeezeHeight + out_length, $fn = 60);
    } else {            
        translate([wall_width*2, wall_width*2, -0.1])
          hull() {
              cube([size[0]-2*wall_width, size[1]-2*wall_width, flatHeight+size[2]+0.2]);
            translate([size[0]/2-wall_width, size[1]/2-2*wall_width, 0]) rotate([180, 0, 0]) cylinder(r = out_depth, h = squeezeHeight + 0.1, $fn = 60);
          }
        translate([size[0]/2 + wall_width, size[1]/2, 0])
            rotate([180, 0, 0]) cylinder(r = out_depth, h = squeezeHeight + out_length-wall_width, $fn = 60);
    }
}




module blower_fan_cooling (flatHeight = 7, squeezeHeight = 30, out_length=10, blower_nozzle_gap = 30, output_angle = 0) {
    difference () {
        blower_fan_cooling_fab(carve = false, flatHeight = flatHeight, squeezeHeight = squeezeHeight, out_length=out_length, blower_nozzle_gap = blower_nozzle_gap, size = blower_out, output_angle = output_angle);
        blower_fan_cooling_fab(carve = true, flatHeight = flatHeight, squeezeHeight = squeezeHeight, out_length=out_length, blower_nozzle_gap = blower_nozzle_gap, size = blower_out, output_angle = output_angle);
    }
}
module blower_fan_cooling_fab (carve = false, flatHeight = 7, squeezeHeight = 15, out_length=10, blower_nozzle_gap = 30, size = blower_out, output_angle = 0) {
    universal_fan_duct_blower_adapter_fab(flatHeight = flatHeight, squeezeHeight = squeezeHeight, size = size, carve = carve, out_length=out_length);
    translate ([-blower_nozzle_gap+3,size[1]/2,-squeezeHeight-out_length]) rotate_about_pt ([0,0,output_angle],[blower_nozzle_gap+6,0,0])universal_fan_duct_outflow(blower_nozzle_gap = blower_nozzle_gap, ring_height = ring_height, head_gap = head_gap, carve = carve);
}

