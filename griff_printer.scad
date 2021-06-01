include <brackets.scad>
include <outside_components.scad>

include <axis.scad>
include <hotend.scad>

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
griffPrinter ("grey");

//hotendShroud();


module griffPrinter (color) {
    %frame(color);
    %translate ([0,0,-3]) bottom_brace(color);

    %translate ([0,20,20]) corner_brace(color);
    translate ([570/2,200,570]) {
        yAxis (color);
        xBracket (1,color);
        translate ([30,-5.2,0]) rotate ([0,0,180]) E3dHolder(color);
        translate ([0,-40.4,0]) rotate ([0,0,0]) e3d_holder_shroud(color);
        translate ([30,20,0]) rotate ([0,0,180]) xBracket (2, color);
    }

    %translate ([40,500,570]) rotate ([0,0,-90]) cornerPulley (color);
    %translate ([570-40,500,570]) rotate ([0,0,180]) cornerPulley (color);
    %translate ([510,0,480]) rotate ([0,-90,0]) YZEndstops (color);

    %translate ([20,0,600]) stepperBracket(color);
}
module yAxis (color) {
 vslot(-446/2,0,0,0,446, color);
 color (color) translate ([446/2-20,0,2]) yBracket();
 color (color) translate ([-446/2+20,20,2]) rotate ([0,0,180]) yBracket();
 //color (color) translate ([446/2+7,10,10]) rotate ([0,90,0]) v_wheel();
 //color (color) translate ([-446/2-7,10,10]) rotate ([0,-90,0]) v_wheel();
 color (color) translate ([446/2-8,-20,-15]) rotate ([0,0,0]) v_wheel();
 color (color) translate ([446/2-8,40,-15]) rotate ([0,0,0]) v_wheel();
 color (color) translate ([-446/2+8,-20,-15]) rotate ([0,0,0]) v_wheel();
 color (color) translate ([-446/2+7,30,-10]) rotate ([0,0,0]) v_wheel();
}

module wCone(ch=5, br=8) {
    difference () {
        cylinder(r1=br,r2=3.5,h=ch);
        translate ([0,0,-1]) cylinder (r=3,h=ch+2, $fn=30);
    }
}
module frame(color) {
    //double Z
    vslot (v,0,v,2,mh-40, color);//orig
        vslot (2*v,0,v,2,mh-40, color);//orig
    vslot (510,0,v,2,mh-40, color);//orig
        vslot (530,0,v,2,mh-40, color);//orig
    vslot (v,480,v,2,mh-40, color);//orig
        vslot (40,480,20,2,mh-40, color);//orig
    vslot (510,480,v,2,mh-40, color);//orig
        vslot (530,480,v,2,mh-40, color);//orig

    //single Z
    vslot (0,0,00,2,fh-20, color);
    vslot (550,0,00,2,fh-20, color);
    vslot (0,480,00,2,fh, color);
    vslot (550,480,00,2,fh, color);
    
    //all X
    vslot (20,0,0,0,530, color);//orig
    vslot (20,480,0,0,530, color);//orig
    vslot (20,480,550,0,530, color);//orig
    vslot (20,480,550+eh,0,530, color);//orig
    
    //bottom Y
    vslot (0,20,0,1,460, color);//orig
    vslot (550,20,0,1,460, color);//orig
    vslot (40,20,00,1,460, color);
    vslot (530-20,20,00,1,460, color);
    
    //top Y
    vslot (00,0,550+eh,1,480, color);
    vslot (550,0,550+eh,1,480, color);   
    
    //middle Y
    vslot (510,0,550,1,480, color);
    vslot (40,0,550,1,480, color);
}

 

 






// rotate as per a, but around point pt
module rotate_about_pt(a, pt) {
    translate(pt)
        rotate(a)
            translate(-pt)
                children();   
}







