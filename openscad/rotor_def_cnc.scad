// Global
$fn=90;

// x size must be double since it is being centered
magnet_size = [6.4, 5, 60];
// This version has 9 magnets on the rotor
magnet_step = [0: 40: 360];

// Rotor (all in millimetres)
r_out_diameter = 159;
r_in_diameter = 149;

module grooves( diameter=1, step=[0: 30: 360], g_size=[1, 1, 1] ) {
    radius = diameter / 2;

    for ( angle = step ) {
        x = radius * cos( angle );
        y = radius * sin( angle );
        translate( [x, y , 0] )
            rotate( a = angle )
                cube( size = g_size, center=true );
    }
}

// Rotor Definition
union() {
 difference() {
    cylinder( h=50, d=r_out_diameter, center=true );
    grooves( r_out_diameter, magnet_step, magnet_size );
    cylinder( h=50, d=r_in_diameter, center=true );
 }

 // Rotor's spokes
 difference() {
    union() {
        cube( size=[5,158,15], center=true );
        rotate( 120 ) cube( size=[5,158,15], center=true );
        rotate( 240 ) cube( size=[5,158,15], center=true );
        cylinder( h=15, d=20, center=true );
    }
    // shaft opening
    cylinder( h=50, d=8, center=true );
    cube( size=[14,2,50], center=true );
    rotate(90) cube( size=[14,2,50], center=true );
 }
}
