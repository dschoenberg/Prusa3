		include <configuration.scad>
include <inc/metric.scad>


base_thickness=14;
base_length=70;
base_leadout=25;
wade_block_depth=28;
m4_nut_height = 3.85;
filament_diameter = 2;
fitting_support = 4;
motor_mount_translation=[50.5,34,0];
filament_feed_hole_offset=filament_diameter+0.5;
hot_end_offset = 5;

module fanMount() {
	translate([-45/2, wade_block_depth/2,0])
	difference() {
		translate([1,0,0])
		cube([45,10,base_thickness]);
	}
}

module fanCutout() {
translate([-40/2, wade_block_depth/2,0])
	difference() {
		translate([0,0,base_thickness])	rotate([-55,0,0]) translate([0,6,0])

		union() {
			translate([4,4,-10])
			screw(r=m3_diameter/2,r_head=m3_diameter/2*1.3, head_drop=5);
	
#	translate([4,4,-6])rotate([0,0,90])
	union() {
		nut(m3_nut_diameter + .2, 3);	
		translate([20/2-1,0,3/2])cube([m3_nut_diameter+20, m3_nut_diameter+1,3], center=true);
	}		
			translate([36,4,-10])
			screw(r=m3_diameter/2,r_head=m3_diameter/2*1.3, head_drop=5);

#	translate([36,4,-6])rotate([0,0,90])
	union() {
		nut(m3_nut_diameter + .2, 3);	
		translate([20/2-1,0,3/2])cube([m3_nut_diameter+20, m3_nut_diameter+1,3], center=true);
	}	

			cube([40,40,10]);

			translate([-10,-10,0])
			cube([60,60,10]);
		}
	}
}

module groovemount(){
	union()
	{	
		cylinder(h=4.76, r=16/2);
		translate([0,0,4.76])cylinder(h=4.64, r=12/2);
		translate([0,0,4.76+4.64])cylinder(h=2, r=16/2);
		translate([0,0,4.76+4.64+2])cylinder(h=(27-4.76-4.64-2), r=12/2);
	}
}

module groovemount_holes () {
	translate([0,0,0])cylinder(h=6, r=16/2);
}

module base() {
	translate([0,0,base_thickness/2])
	cube_fillet([base_length,wade_block_depth,base_thickness],center=true);
}

module fitting() {
	nut(m4_nut_diameter + .2, m4_nut_height+.2);	
	translate([0,0,1]) cylinder(r=5/2, h=8);
	//translate([0,0,1+5]) cylinder(r=10/2+.3, h=10);
}

module baseMount() {
// Mounting holes on the base.
			for (mount=[0:1])
			{
rotate([90,0,0])
				union() {
				translate([25*((mount<1)?1:-1)+2.8,0,0])
				rotate([-90,0,0]) rotate(360/16) cylinder(r=m4_diameter/2,h=base_thickness+2,$fn=8);	
	
				translate([25*((mount<1)?1:-1)+2.8,base_thickness,0])
				rotate([-90,0,0])
				cylinder(r=m4_nut_diameter/2,h=base_thickness,$fn=6);	
}
			}
}

translate([0,0, base_thickness])
rotate([180,0,0])
difference() {
	union() {
		base();
		translate([hot_end_offset,0,0]) fanMount();
	}

	translate([hot_end_offset,0,0])
	union() {
		cylinder(r=filament_diameter, h=20);
		translate([0,0,-.2])groovemount_holes();
		translate([0,0, 4.76+1.0]) fitting();

	}

	translate([0,0,-m4_nut_height])baseMount();
	translate([hot_end_offset,0,0])	fanCutout();	
}
