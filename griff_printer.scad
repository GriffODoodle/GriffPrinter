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


%frame("grey");
%translate ([0,0,-3]) bottom_brace();

%translate ([0,20,20]) corner_brace();
translate ([570/2,200,570]) {
    %yAxis ("grey");
    xBracket (1,"grey");
    translate ([30,20,0]) rotate ([0,0,180]) xBracket (2, "grey");
}

%translate ([40,500,570]) rotate ([0,0,-90]) cornerPulley ("grey");
%translate ([570-40,500,570]) rotate ([0,0,180]) cornerPulley ("grey");
translate ([510,0,480]) rotate ([0,-90,0]) YZEndstops ("white");

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
 color (color) translate ([446/2+7,10,10]) rotate ([0,90,0]) vWheel();
 color (color) translate ([-446/2-7,10,10]) rotate ([0,-90,0]) vWheel();
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