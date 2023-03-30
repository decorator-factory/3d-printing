$fn = 64;

module stick() {
/*
   ___       _
   \  \      |
    \  \     1.0
     \  \    |
      \__\   _
*/
    linear_extrude(1)
        polygon([
            [-0.75 + 0, 1  ],
            [-0.75 + 0.4, 1],
            [0.2, 0],
            [-0.2, 0],
        ]);
}

module base_haskell_logo() {
    stick();
    translate([-0.55, -1, 1])
    rotate([0, 180, 0])
        stick();

    translate([0.6, 0, 0])
        union() {
            stick();
            translate([-0.55, -1, 1])
            rotate([0, 180, 0])
                stick();
            translate([0.55, -1, 0])
                stick();
        }

    translate([0.7, 0, 0])
        intersection() {
            union() {
                translate([0, 0, 0])
                    linear_extrude(1)
                        square([1, 0.35]);

                translate([0, -0.5, 0])
                    linear_extrude(1)
                        square([1, 0.35]);
            }

            translate([0.05, 0, 0])
            union() {
                translate([0.4, 0, 0])
                    stick();
                translate([0.77, 0, 0])
                    stick();
                translate([1.15, 0, 0])
                    stick();

                translate([0.93, -0.95, 0])
                    stick();
                translate([1.33, -0.95, 0])
                    stick();
            }
        }
}

// Logo
translate([-1.3, -1.05, 1])
    scale([6, 6, 1])
        base_haskell_logo();

// Top margins
difference() {
    translate([0, 0, 0.5])
        cylinder(h=2.5, d=24, center=true);

    cylinder(h=6, d=23, center=true);
}

// Bottom cylinder with hole
difference() {
    cylinder(h=1.5, d=24, center=true);

    translate([5, 5, 0])
        cylinder(h=10, d=6, center=true);
}
