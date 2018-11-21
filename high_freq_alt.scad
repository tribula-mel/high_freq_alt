// Global
$fn=90;

magnet_size = [0.3, 0.5, 6];
// This version has 15 magnets on the rotor
magnet_step = [0: 24: 360];

// Has to be a bit larger z wise due to the rengdering artefact
coil_size = [1, 0.5, 6];
// This version has 16 poles for the coils
coil_step = [0: 22.5: 360];
coil_grooves = [1, 0.8, 6];

// Rotor (all in centimetres)
r_out_diameter = 39.9;
r_in_diameter = 37.9;
r_out_radius = r_out_diameter / 2 ;

// Stator (all in centrimetres)
s_out_diameter = 42;
s_in_diameter = 40;
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
    cylinder( h=5, d=r_out_diameter, center=true );
    grooves( r_out_diameter, magnet_step, magnet_size );
    cylinder( h=5, d=r_in_diameter, center=true );
 }

 // Stator Definition
 difference() {
    cylinder( h=5, d=s_out_diameter, center=true );
    grooves( s_in_diameter, coil_step, coil_grooves );
    rotate(3.7) grooves( s_in_diameter, coil_step, coil_grooves );
    cylinder( h=5, d=s_in_diameter, center=true );
    holes( 13.8, [0: 90: 360], d=0.4, h=6 );
 }

 // Rotor's spokes
 difference() {
    union() {
        cube( size=[0.5,38.9,3], center=true );
        rotate( 120 ) cube( size=[0.5,38.9,3], center=true );
        rotate( 240 ) cube( size=[0.5,38.9,3], center=true );
        cylinder( h=5, d=3, center=true );
    }
    cylinder( h=5, d=0.6, center=true );
    cube( size=[1.4,0.2,5], center=true );
    rotate(90) cube( size=[1.4,0.2,5], center=true );
 }
}
