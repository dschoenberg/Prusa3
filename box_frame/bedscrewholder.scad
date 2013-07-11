include <configuration.scad>
include <inc/metric.scad>

bedWidth = 9.74;
bedHeight = 4;

difference() {
translate([-bedWidth*1.4/2, -bedWidth*2/2,0])cube([bedWidth*1.4, bedWidth*2, 6]);
  union(){
		translate([-bedWidth*4/2, -bedWidth/2,3]) cube([bedWidth*4, bedWidth, 10]);
		 nut(m3_nut_diameter + .2, 2.25+.2);		

		cylinder(h = bedHeight*2, r = m3_diameter/2+.1);
}
}
