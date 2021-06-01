
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


module xBracket (type, color) {
    xWidth = 30;
    xw=xWidth;
    color (color ) {
        if (type==1) {
            %translate ([0,5,20+10])rotate ([-90,0,0]) v_wheel();
            %translate ([xw,5,20+10])rotate ([-90,0,0]) v_wheel();
            %translate ([xw/2,5,0-10])rotate ([-90,0,0]) v_wheel();
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