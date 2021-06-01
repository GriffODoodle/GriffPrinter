module stepperBracket (color) {
    thickness = 4.8;
//    motor_template = [ 1.7*25.4,   3,    31,   22, "NEMA 17" ],
    motor_width = 1.7*25.4; 
    bolt_radius = 1.5;
    bolt_spacing = 31;
    bolt_inset = (motor_width - bolt_spacing) / 2;
    center_radius = 11;
    //motor mount plate
    color (color) {
        translate ([30-motor_width/2,thickness,0]) {
            difference () {
                cube([motor_width,motor_width,thickness]);
             translate([motor_width/2,motor_width/2,-1])
               cylinder(thickness+2,center_radius,center_radius);
             translate([motor_width-bolt_inset,motor_width-bolt_inset,-1])
               cylinder(thickness+2,bolt_radius,bolt_radius);
             translate([motor_width-bolt_inset,bolt_inset,-1])
               cylinder(thickness+2,bolt_radius,bolt_radius);
             translate([bolt_inset,bolt_inset,-1])
               cylinder(thickness+2,bolt_radius,bolt_radius);
             translate([bolt_inset,motor_width-bolt_inset,-1])
               cylinder(thickness+2,bolt_radius,bolt_radius);
            }
        }
        
        difference () {
            cube ([30-motor_width/2,thickness+motor_width,40]);
            for (j = [0:1]) {
                translate ([-1,10,20*j+12]) rotate ([0,90,0]) cylinder (r = 3,h=10);
            }
            translate ([-1,20,40]) rotate ([-51.52,0,0]) cube ([30-motor_width/2+2,50,50]);
        }
        difference () {
            translate ([30-motor_width/2,0,0,]) cube ([motor_width,thickness,40]);
            translate ([30-motor_width/2,-1,40]) rotate ([0,39.185,0]) cube ([70,thickness+2,50]);
        }
    }
}

module YZEndstops (color) {
    color (color) {
        difference () {
            union () {
                cube([130,20,3]);
                translate ([50,0,0]) cube ([20,100,3]);
            }
            //to attatch to frame
            translate ([10,10,-1]) cylinder (r=3,h=5);
            translate ([40,10,-1]) cylinder (r=3,h=5);
            //z endstop
            translate ([60,70,-1]) cylinder (r=2,h=5);
            translate ([60,90,-1]) cylinder (r=2,h=5);
            //y endstop
            translate ([100,10,-1]) cylinder (r=2,h=5);
            translate ([120,10,-1]) cylinder (r=2,h=5);
        }
    }
}


module cornerPulley(color) {

    color (color) difference () {
        union () {
            hull () {
                translate ([2,2,0]) cylinder (r=2,h=2);
                translate ([38,2,0]) cylinder (r=2,h=2);
                translate ([2,38,0]) cylinder (r=2,h=2);
                translate ([38,38,0]) cube (2);
                //translate ([50,15,0]) cylinder (r=10,h=2);
                //translate ([15,50,0]) cylinder (r=10,h=2);
            }
            //translate ([30,30,2-0.01]) cylinder (r=4,h=1);
            //translate ([30,30,2+1+ph+ph+0.01]) cylinder (r=4,h=1);
            translate ([20,20,-20]) cube (20);
        }
        translate ([30,30,-50]) cylinder (r=3,h=100);
        translate ([30,10,-1]) cylinder(r=2.5,h=4);
        translate ([10,10,-1]) cylinder(r=2.5,h=4);
        translate ([10,30,-1]) cylinder(r=2.5,h=4);
        translate ([26,26,-26]) cylinder (r=3,h=20);
        translate ([26,26,-6]) rotate ([-90,0,0]) cylinder (r=3,h=20);
        translate ([26,26,-6]) rotate ([0,90,0]) cylinder (r=3,h=20);
        translate ([23,26,-26]) cube (20);
        translate ([26,23,-26]) cube (20);
        translate ([26,26,-23]) cube (20);
        translate ([26,26,-6]) sphere (3);
        translate ([30,19,-10]) rotate ([-90,0,0]) cylinder (r = 2.5, h= 5);
        translate ([19,30,-10]) rotate ([0,90,0]) cylinder (r = 2.5, h= 5);

    }
}



module corner_brace(){
    union () {
        difference () {
            union () {
                cube ([60,40,3]);
                translate ([20,0,-5]) cube ([20,40,6]);
            }
            for (i =[0:2]) {
                for (j = [0:1]) {
                    translate ([20*i+10,20*j+10,-6]) cylinder (r = 3,h=10);
                }   
            }
        }
        difference () {
            cube ([60,3,40]);
            for (i =[0:2]) {
                for (j = [0:1]) {
                    translate ([20*i+10,-1,20*j+10]) rotate ([-90,0,0]) cylinder (r = 3,h=5);
                }   
            }
        }
        for (i=[0:3]) {
            translate ([i*(57/3),0,0]) {
                difference () {
                    cube ([3,40,40]);
                    translate ([-1,3,40]) rotate ([-45,0,0]) cube ([5,80,80]);
                }
            }
        }
        
    }
}








module bottom_brace() {
    union () {
        difference () {
            cube ([60,60,3]);
            for (i =[0:2]) {
                for (j = [0:2]) {
                    translate ([20*i+10,20*j+10,-1]) cylinder (r = 3,h=5);
                }   
            }
        }
        translate ([20,20,0]) {
            difference () {
                union () {
                    cube ([20,40,8]);
                    translate ([10,10,0]) cylinder(r=5,h=18);
                    translate ([10,10,7]) cylinder(r1=7,r2 = 4,h=3);
                    
                    translate ([10,30,0])cylinder(r=5,h=18);
                    translate ([10,30,7])cylinder(r1=7,r2 = 4,h=3);
                }
                translate ([10,10,-1])cylinder(r=3,h=20);
                translate ([10,30,-1])cylinder(r=3,h=20);
            }
        }
    }
}









