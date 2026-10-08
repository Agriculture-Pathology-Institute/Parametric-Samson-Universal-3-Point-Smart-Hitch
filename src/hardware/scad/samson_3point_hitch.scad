// ====================================================================================
// SAMSON IRON WORKS & AGRICULTURE PATHOLOGY INSTITUTE COOPERATIVE PIPELINE
// Subsystem: samson_3point_hitch.scad (Universal Smart Implement Hitch Interface)
// Source Framework: github.com/Agriculture-Pathology-Institute/Electromagnetic-Actuator
// Compatibility: Standard CAT / John Deere Category III Mechanical Mounting Layouts
// Center Origin (0,0,0) = Geometric Centerpoint of the Main Chassis Mating Face Plate
// ====================================================================================

$fn = 100; // High-precision CNC milling and heavy forge tooling path resolution

// --- Samson Heavy Industrial Constants (mm) ---
inch_to_mm         = 25.4;
hitch_plate_w      = 32.0 * inch_to_mm;  // 812.80 mm standard industrial backing width
hitch_plate_h      = 600.00;             // Total vertical attachment plate height
lower_arm_length   = 750.00;             // Heavy forged steel lift arm extension track
ema_housing_dia    = 110.00;             // Fits 48V-5A Bitter coil actuator shells natively [0.13]

// Active Vehicle Interface Mapping Identifier
// 1 = Caterpillar Fleet (Heavy Yellow), 2 = John Deere (Ag Green), 3 = Rheinmetall (Hardened Drab)
TARGET_FLEET_INDEX = 2;

module universal_chassis_mating_plate() {
    echo(str("STAMPING SAMSON MASTER HITCH INTERFACE NODE FOR FLEET ID: ", TARGET_FLEET_INDEX));
    // Main vertical backing slab constructed from structural low-alloy weldable plate steel
    color((TARGET_FLEET_INDEX == 1) ? "Gold" : (TARGET_FLEET_INDEX == 2) ? "ForestGreen" : "OliveDrab") {
        difference() {
            cube([hitch_plate_w, 35.0, hitch_plate_h], center=true);
            
            # // Universal Implement Pin Mounting Bushings (Category III Spec)
            for (x_side = [-hitch_plate_w/2 + 50, hitch_plate_w/2 - 50]) {
                for (z_step = [-hitch_plate_h/3, hitch_plate_h/3]) {
                    translate([x_side, 0, z_step])
                        rotate([90, 0, 0]) cylinder(d=31.75, h=40, center=true); // 1.25" pin standard
                }
            }
        }
    }
}

module integrated_power_by_wire_ema_vaults() {
    // Generates the twin vertical electromagnetic lifting cylinders replacing standard hydraulics [0.13]
    color("DimGrey") {
        for (side = [-1, 1]) {
            translate([side * (hitch_plate_w/2 - 120), 120, -50]) {
                difference() {
                    // Outer cast magnetic protective steel isolation barrel [0.13]
                    cylinder(d=ema_housing_dia, h=450, center=true);
                    // Internal clear cavity matching the fused silica dielectric liner sleeve [0.13]
                    cylinder(d=76.20, h=454, center=true);
                }
                // Central chrome piston rod extending vertically to actuate lift link arms [0.13]
                translate([0, 0, 100]) color("Chrome") cylinder(d=35.0, h=420, center=true);
            }
        }
    }
}

module forged_lower_lift_links() {
    // Heavy dual lower draft links that swing vertically to hoist heavy tools
    color("DarkSlateGrey") {
        for (side = [-1, 1]) {
            translate([side * (hitch_plate_w/2 - 160), lower_arm_length/2, -hitch_plate_h/3]) {
                rotate([15, 0, 0]) // Shown under simulated 15° lifting pivot lift angle
                    difference() {
                        cube([45.0, lower_arm_length, 90.0], center=true);
                        // Implement attachment point swivel eyelet
                        translate([0, lower_arm_length/2 - 40, 0])
                            rotate([90, 0, 0]) cylinder(d=32.0, h=50, center=true);
                    }
            }
        }
    }
}

// --- Unify Samson Smart Hitch Superstructure Assembly ---
union() {
    universal_chassis_mating_plate();
    integrated_power_by_wire_ema_vaults();
    forged_lower_lift_links();
}
