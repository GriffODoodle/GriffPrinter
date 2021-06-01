module v_wheel() {
    cylinder (r=8, h=10);
    cylinder (r1=10,r2=12,h=2);
    translate ([0,0,8]) cylinder (r1=12,r2=10,h=2);
    translate ([0,0,2]) cylinder (r=12,h=6);
}

module vslot(x,y,z,d,h,V_color="gold") {
    if (d==0) translate ([x,y,z]) rotate ([0,90,0]) translate ([-10,10,0]) color(V_color) extrusion_profile_20x20_v_slot(size=20, height=h);
    if (d==1) translate ([x,y,z]) rotate ([-90,0,0]) translate ([10,-10,0])  color(V_color) extrusion_profile_20x20_v_slot(size=20, height=h);
    if (d==2) translate ([x,y,z]) rotate ([0,0,0]) translate ([10,10,0])  color(V_color) extrusion_profile_20x20_v_slot(size=20, height=h);
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

 

module extrusion_profile_20x20_v_slot_part(size=20) { //quarter v-slot to be combined
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