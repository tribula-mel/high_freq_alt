// Global
$fn=90;

magnet_size = [3, 5, 60];
// This version has 9 magnets on the rotor
magnet_step = [0: 40: 360];

// Has to be a bit larger z wise due to the rengdering artefact
coil_size = [10, 5, 60];
// This version has 8 poles for the coils
coil_step = [0: 45: 360];
coil_grooves = [5, 8, 60];

// Rotor (all in millimetres)
r_out_diameter = 159;
r_in_diameter = 152;
r_out_radius = r_out_diameter / 2 ;

// Stator (all in millimetres)
s_out_diameter = 170;
s_in_diameter = 160;
s_out_radius = r_out_diameter / 2 ;

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

// fastener holes
module holes( offset=5, step=[0: 90: 360], d=0, h=0 ) {
    radius = (s_out_diameter + s_in_diameter) / 4;
    for ( angle = step ) {
        x = radius * cos( angle + offset );
        y = radius * sin( angle + offset );
        translate( [x, y, 0] )
                cylinder( h=h, d=d, center=true );
    }
}

union() {
 // Rotor Definition
 difference() {
    cylinder( h=50, d=r_out_diameter, center=true );
    grooves( r_out_diameter, magnet_step, magnet_size );
    cylinder( h=50, d=r_in_diameter, center=true );
 }

 // Stator Definition
 difference() {
     cylinder( h=50, d=s_out_diameter, center=true );
     grooves( s_in_diameter, coil_step, coil_grooves );
     // rotate for angle that represents (5 + 8) mm
     // that is magnet y + coil groove y sizes
     rotate(-9.31) grooves( s_in_diameter, coil_step, coil_grooves );
     cylinder( h=50, d=s_in_diameter, center=true );
     holes( 13.8, [0: 90: 360], d=3, h=60 );
 }

 // Rotor's spokes
 difference() {
    union() {
        cube( size=[5,159,15], center=true );
        rotate( 120 ) cube( size=[5,159,15], center=true );
        rotate( 240 ) cube( size=[5,159,15], center=true );
        cylinder( h=50, d=20, center=true );
    }
    // shaft opening
    cylinder( h=50, d=8, center=true );
    cube( size=[14,2,50], center=true );
    rotate(90) cube( size=[14,2,50], center=true );
 }
}
