$fn = 60;
//Constants
pulleyHeight = 10;
ph = pulleyHeight;

pulleyWidth = 32;
pw = pulleyWidth;

pulleyOverlap = 2;
po = pulleyOverlap;

frameWidth = 570;
fw = frameWidth;
mainHeight = 570;
mh = mainHeight;
extraHeight= 120;
eh = extraHeight;
frameHeight = mh + eh;
fh = frameHeight;
sideWidth=40;
sw = sideWidth;
vSlotSize = 20;
v = vSlotSize;
v2 = 2*v;

//universal fan duct variables
    // Optimize part for quickest printing - use an integer multiple of the printer's nozzle size
    wall_width = 1;    // Wall thickness - should be a multiple of machine_nozzle;

    // Distance between J-heads
    head_gap = 0;	// 0,20,26,30
    // Size of the output of the blower
    blower_out= [16.3, 25.5, 3];
    out_depth = 8;
    // Thickness of the outflow
    ring_height = 6;
    tolerance = 0.15;
//griffPrinter ("grey");

hotendShroud();

module griffPrinter (color) {
    %frame(color);
    %translate ([0,0,-3]) bottom_brace(color);

    %translate ([0,20,20]) corner_brace(color);
    translate ([570/2,200,570]) {
        yAxis (color);
        xBracket (1,color);
        translate ([30,-5.2,0]) rotate ([0,0,180]) E3dHolder(color);
        translate ([0,-40.4,0]) rotate ([0,0,0]) E3dHolder_Shroud(color);
        translate ([30,20,0]) rotate ([0,0,180]) xBracket (2, color);
    }

    %translate ([40,500,570]) rotate ([0,0,-90]) cornerPulley (color);
    %translate ([570-40,500,570]) rotate ([0,0,180]) cornerPulley (color);
    %translate ([510,0,480]) rotate ([0,-90,0]) YZEndstops (color);

    %translate ([20,0,600]) stepperBracket(color);
}



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

module xBracket (type, color) {
    xWidth = 30;
    xw=xWidth;
    color (color ) {
        if (type==1) {
            %translate ([0,5,20+10])rotate ([-90,0,0]) vWheel();
            %translate ([xw,5,20+10])rotate ([-90,0,0]) vWheel();
            %translate ([xw/2,5,0-10])rotate ([-90,0,0]) vWheel();
        }
        translate  ([0,-3,20+10]) rotate ([-90,0,0]) wCone(8,6);
        translate  ([xw,-3,20+10]) rotate ([-90,0,0]) wCone(8,6);
        translate  ([xw/2,-3,0-10]) rotate ([-90,0,0]) wCone(8,6);
        if (type==1) difference () {
            translate ([xw/2-10,-5,39.9]) cube([20,4,30]);
            translate ([xw/2-4,-6,40+30-6]) rotate ([-90,0,0]) cylinder(r=1.5, h=6);
            translate ([xw/2+4,-6,40+30-6]) rotate ([-90,0,0]) cylinder(r=1.5, h=6);
        }
        difference () {
            union () {
                translate ([-10,-5,-20]) cube([xw+20,4,60]);
                //translate ([xw/2-13.5,-7,-3]) cube ([27,5,27]);
            }
            translate ([xw+10-6,-6,2]) cube ([3,6,1+ph+1]);
            translate ([-10+3,-6,2+1+ph+1-po]) cube ([3,6,1+ph+1]);
            translate  ([0,-6,20+10]) rotate ([-90,0,0]) cylinder (r=3,h=10);
            translate  ([xw,-6,20+10]) rotate ([-90,0,0]) cylinder (r=3,h=10);
            translate  ([xw/2,-6,0-10]) rotate ([-90,0,0]) cylinder (r=3,h=10);
            
            translate  ([-6,-6,5]) rotate ([-90,0,0]) cylinder (r=1,h=10);
            translate  ([-6,-6,-5]) rotate ([-90,0,0]) cylinder (r=1,h=10);
            
            translate  ([xw/2-7,-8,10]) rotate ([-90,0,0]) cylinder (r=1.5,h=10);
            translate  ([xw/2+7,-8,10]) rotate ([-90,0,0]) cylinder (r=1.5,h=10);
        }
    }
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
module E3dHolder_Shroud (color) {
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
module yAxis (color) {
 vslot(-446/2,0,0,0,446, color);
 color (color) translate ([446/2-20,0,2]) yBracket();
 color (color) translate ([-446/2+20,20,2]) rotate ([0,0,180]) yBracket();
 //color (color) translate ([446/2+7,10,10]) rotate ([0,90,0]) vWheel();
 //color (color) translate ([-446/2-7,10,10]) rotate ([0,-90,0]) vWheel();
 color (color) translate ([446/2-8,-20,-15]) rotate ([0,0,0]) vWheel();
 color (color) translate ([446/2-8,40,-15]) rotate ([0,0,0]) vWheel();
 color (color) translate ([-446/2+8,-20,-15]) rotate ([0,0,0]) vWheel();
 color (color) translate ([-446/2+7,30,-10]) rotate ([0,0,0]) vWheel();
}
module yBracket () {
    difference () {
        union () {
            
            difference (){
                translate ([0,-2-pw-2,-4]) cube ([22,2+pw+2+20+2+pw+2,4+1+ph+1-po+1+ph+1+4]);
                translate ([-0.1,-0.1,-2.1]) cube (20.2);
                translate ([-2,1.6,1.6-2]) cube ([22,16.8,16.8]);
                //translate ([10,10,-2]) cylinder(r=2,h=28, $fn=30);
                //translate ([10,-4,10]) rotate([-90,0,0]) cylinder(r=2,h=28, $fn=30);
                translate ([10,10,10-2]) rotate([0,90,0]) cylinder(r=3,h=100, $fn=30);
                translate ([-5,-pw-2,0]) cube([28,pw,1+ph+1]);
                  //  translate ([-2,-7,0]) cube([8,5,10]);
                translate ([-5,22,1+ph+1-po]) cube([28,pw,1+ph+1]);
                  //  translate ([-2,22,10]) cube([8,5,10]);
                
            translate ([22-5,-50,-4-2]) rotate ([0,45,0]) cube([5,200,10]);
            }   
            translate ([12,-2-(pw/2),0-0.01]) cylinder (r=4,h=1);
            translate ([12,-2-(pw/2),1+ph+0.01]) cylinder (r=4,h=1);
            translate ([12,20+2+(pw/2),1+ph+1-po-0.01]) cylinder (r=4,h=1);
            translate ([12,20+2+(pw/2),1+ph+1-po+1+ph+0.01]) cylinder (r=4,h=1);
            translate ([22-0.01,10,8]) rotate ([0,90,0]) wCone();
            translate ([12,-2-(pw/2),-2+0.01]) rotate ([180,0,0]) wCone();
            translate ([12,20+2+(pw/2),-2+0.01]) rotate ([180,0,0]) wCone();

        }
        translate ([12,-2-(pw/2),-50]) cylinder (r=3,h=100);
        translate ([12,20+2+(pw/2),-50]) cylinder (r=3,h=100);    
    }
}
module wCone(ch=5, br=8) {
    difference () {
        cylinder(r1=br,r2=3.5,h=ch);
        translate ([0,0,-1]) cylinder (r=3,h=ch+2, $fn=30);
    }
}
module vWheel() {
    cylinder (r=8, h=10);
    cylinder (r1=10,r2=12,h=2);
    translate ([0,0,8]) cylinder (r1=12,r2=10,h=2);
    translate ([0,0,2]) cylinder (r=12,h=6);
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









module frame(color) {


    
    
    vslot (v,0,v,2,mh-40, color);//orig
        vslot (2*v,0,v,2,mh-40, color);//orig
    vslot (510,0,v,2,mh-40, color);//orig
        vslot (530,0,v,2,mh-40, color);//orig
    vslot (v,480,v,2,mh-40, color);//orig
        vslot (40,480,20,2,mh-40, color);//orig
    vslot (510,480,v,2,mh-40, color);//orig
        vslot (530,480,v,2,mh-40, color);//orig
    //vslot (sideWidth,0,20,2,530);
    //vslot (550-sideWidth,0,20,2,530);
    //vslot (0,0,530+20+20,2,exHeight);
    //vslot (550,0,530+20+20,2,exHeight);
    //vslot (0,440,530+20+20,2,exHeight);
    //vslot (550,440,530+20+20,2,exHeight);
    vslot (0,0,00,2,fh-20, color);
    vslot (550,0,00,2,fh-20, color);
    vslot (0,480,00,2,fh, color);
    vslot (550,480,00,2,fh, color);
   
 
   
    vslot (20,0,0,0,530, color);//orig
    vslot (20,480,0,0,530, color);//orig
    //vslot (20,0,550,0,sideWidth);
    //vslot (570-sideWidth-20,0,550,0,sideWidth);
    vslot (20,480,550,0,530, color);//orig
    vslot (20,480,550+eh,0,530, color);//orig
   
 
    vslot (0,20,0,1,460, color);//orig
    vslot (550,20,0,1,460, color);//orig
    //vslot (0,20,550,1,460);
    //vslot (550,20,550,1,460);
    vslot (40,20,00,1,460, color);
    vslot (530-20,20,00,1,460, color);
    vslot (00,0,550+eh,1,480, color);
    vslot (550,0,550+eh,1,480, color);   
    
    vslot (510,0,550,1,480, color);
    vslot (40,0,550,1,480, color);

   

}

 

 






module vslot(x,y,z,d,h,V_color="gold") {

    if (d==0) translate ([x,y,z]) rotate ([0,90,0]) translate ([-10,10,0]) color(V_color) extrusion_profile_20x20_v_slot(size=20, height=h);

 

    if (d==1) translate ([x,y,z]) rotate ([-90,0,0]) translate ([10,-10,0])  color(V_color) extrusion_profile_20x20_v_slot(size=20, height=h);

 

    if (d==2) translate ([x,y,z]) rotate ([0,0,0]) translate ([10,10,0])  color(V_color) extrusion_profile_20x20_v_slot(size=20, height=h);

}

 

 

module extrusion_profile_20x20_v_slot(size=20, height=10) {

                linear_extrude(height=height) {

                                union() {

                                                extrusion_profile_20x20_v_slot_part(size);

                                                rotate([0,0,90])  extrusion_profile_20x20_v_slot_part(size);

                                                rotate([0,0,180]) extrusion_profile_20x20_v_slot_part(size);

                                                rotate([0,0,270]) extrusion_profile_20x20_v_slot_part(size);

                                }

                }

}

 

module extrusion_profile_20x20_v_slot_part(size=20) {

                d = 5;

                r = 1.5;

                s1 = 1.8;

                s2 = 2;

                s3 = 6;

                s4 = 6.2;

                s5 = 9.5;

                s6 = 10.6;

                s7 = 20;

 

                reSize = size/20; // Scalling

 

                k0 = 0;

                k1 = d*0.5*cos(45)*reSize;

                k2 = d*0.5*reSize;

                k3 = ( (s7*0.5-s3)-s1*0.5*sqrt(2) )*reSize;

                k4 = s4*0.5*reSize;

                k5 = ( s7*0.5-s3 )*reSize;

                k6 = s6*0.5*reSize;

                k7 = ( s6*0.5+s1*0.5*sqrt(2) )*reSize;

                k8 = ( s7*0.5-s2 )*reSize;

                k9 = s5*0.5*reSize;

                k10 = s7*0.5*reSize;

                k10_1 = k10-r*(1-cos(45))*reSize;

                k10_2 = k10-r*reSize;

 

                polygon(points=[

                                [k1,k1],[k0,k2],[k0,k5],[k3,k5],

                                [k6,k7],[k6,k8],[k4,k8],[k9,k10],

                                [k10_2,k10],[k10_1,k10_1],

                                [k10,k10_2],

                                [k10,k9],[k8,k4],[k8,k6],[k7,k6],

                                [k5,k3],[k5,k0],[k2,k0]

                ]);

}

 

module extrusion_profile_20x20_v_slot_smooth(size=20, height=10) {

                linear_extrude(height=height) {

                                difference() {    

                                                union() {

                                                                extrusion_profile_20x20_v_slot_part_smooth(size);

                                                                rotate([0,0,90])  extrusion_profile_20x20_v_slot_part_smooth(size);

                                                                rotate([0,0,180]) extrusion_profile_20x20_v_slot_part_smooth(size);

                                                                rotate([0,0,270]) extrusion_profile_20x20_v_slot_part_smooth(size);

                                                }

                                                circle([0,0],r=size/20.*2.5);

                                }

                }

}

 

module extrusion_profile_20x20_v_slot_part_smooth(size=20) {

                r_center = 0.5*size-1.5*size/20;

                union() {

                                translate ([r_center,r_center]) circle(r=1.5*size/20);

                                extrusion_profile_20x20_v_slot_part(size);

                }

}

module stepper(){

    motor_height=34;

                difference(){

//motor

                                union(){

                                                translate([0,0,motor_height/2]){

                                                                intersection(){

                                                                                cube([42.3,42.3,motor_height], center = true);

                                                                                rotate([0,0,45]) translate([0,0,-1]) cube([55, 55 ,motor_height+2], center = true);

                                                                }

                                                }

                                                translate([0, 0, motor_height]) cylinder(h=2, r=11, $fn=12);

                                                translate([0, 0, motor_height+2]) cylinder(h=20, r=2.5, $fn=12);

                                }

//screw holes

                                for(i=[0:3]){

                                                                rotate([0, 0, 90*i])translate([15.5, 15.5, motor_height-4.5]) cylinder(h=5, r=1.5, $fn=12);

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

module hotendShroud() {

    E3dHolder();
    translate ([30,36,0]) rotate([0,0,180]) E3dHolder_Shroud();
    translate ([30,3,-25]) {
        blower_fan_cooling (flatHeight = 1, squeezeHeight = 10, out_length=7, blower_nozzle_gap = 18, output_angle=-10);
    }
    %translate ([15,20.5,10.5]) rotate ([0,0,90]) E3DHotend (); //From thing 80904
}

module E3DHotend () {
    color("silver"){
    difference(){
        //top mounting point
    union(){
    translate([0,0,8.64]) cylinder(3.66,8,8);
    cylinder(12.3,6,6);
    cylinder(3.04,8,8);
        //small thermal break
    translate([0,0,-6.6]) cylinder(6.6,4.575,4.575);
    translate([0,0,-4.15]) cylinder(1.9,8,8);
        //big thermal break
    translate([0,0,-38.14]) cylinder(31.54,4.575,4.575); //smallest inner shaft
    translate([0,0,-38.14]) cylinder(18.88,6.5,6.5); //medium inner shaft
    translate([0,0,-38.14]) cylinder(14.66,7.5,7.5); //large-bottom inner shaft
    for (z = [0:7]){
    translate([0,0,-8.8-4.2*z]) cylinder(2,12.5,12.5);}} //heatsink fins
        //through and through hole
    union(){
    translate([0,0,10.31]) cylinder(2,1,4.465); //filament funnel - from ref. drawing
    translate([0,0,-39.1]) cylinder(51.4,1,1,$fn=20);}}} //filament hole
        
        //begin heater block (from ref. drawings and extrapolation, not measured)
    color("gray"){
    translate([0,0,-40.14]) cylinder(2.1,1.2,1.2);
    difference(){
    translate([-4,-7.5,-48.14]) cube([15,15,8]);
    union(){
    translate([7,8,-44.14]) rotate([90,0,0]) cylinder(16,2,2,$fn=20);
    translate([9,-4.5,-46.9]) rotate([90,0,0]) cylinder(3.1,.5,.5,$fn=20);}}}
    translate([0,0,-51.14]) cylinder(3,4,4,$fn=6);
    color("goldenrod") translate([0,0,-53.14]) cylinder(2,.4,3.5,$fn=20);
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





// rotate as per a, but around point pt
module rotate_about_pt(a, pt) {
    translate(pt)
        rotate(a)
            translate(-pt)
                children();   
}







module c_fan(radius, height) {

   color("red") cylinder(r=radius,h=1,center=true);

   rotate([0,0,$t*10])
   for (theta= [0:10:350]) {
       rotate([0.0,0.0,theta]){
           translate([radius-(radius*0.15),0.5,0.0]) rotate([0,0,15]) cube([radius*0.3,1.0,height-2.0],center=true);
       }
   }

   color("orange") cylinder(r=radius*0.4,h=height-3,center=true);
   color("black") cylinder(r=radius*0.1,h=height,center=true);

}

module blower_50mm(){

   c_fan(radius=22.0, height=19.0);

    difference(){
        hull(){
           translate([21.75,-20.00,0]) cylinder(r=3.25,h=21.0,center=true);
           translate([-21.75,19.75,0]) cylinder(r=3.25,h=21.0,center=true);
        }
       translate([21.75,-20.00,0]) cylinder(r=2.25,h=21.5,center=true);
       translate([-21.75,19.75,0]) cylinder(r=2.25,h=21.5,center=true);
       cylinder(r=24, h=19.0,center=true);
   }

   difference(){
       translate([12,12.5,0])  cube([26.0,25.0,20.0],center=true);
       translate([12.0,12.5,0])  cube([23.5,26.0,17.0],center=true);
       cylinder(r=18.0, h=22.0,center=true);
   }

   difference(){
       cube([50.0,50.0,20.0],center=true);
       cylinder(r=18.0, h=22.0,center=true);
       cylinder(r=23.5, h=17.0,center=true);
       translate([12,13.5,0.0]) cube([23.0,27.0,17.0],center=true);
       rotate_extrude () {
           translate([25,-11,0]) square(22);
       }
   }
}