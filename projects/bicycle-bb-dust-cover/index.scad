$fn = 32;

outer_cap_diameter = 24;
outer_insert_diameter = 20.5;
inner_insert_diameter = 19;

// Bottom cap
difference() {
    translate([0, 0, -1.5])
        cylinder(h = 3, d = outer_cap_diameter, center = true);
    translate([-outer_cap_diameter/2, -0, 0])
        cube([3, outer_cap_diameter, 10], center=true);
}

// Insert
difference() {
    union() {
        cylinder(h = 5, d = outer_insert_diameter);
        translate([0, 0, 2.5])
            cylinder(h = 1, d = outer_insert_diameter + 0.7);
    }
    cylinder(h = 5 + 0.1, d = inner_insert_diameter);
    #translate([0, 0, 3.1])
    cube([outer_cap_diameter, 5, 4], center=true);
}
