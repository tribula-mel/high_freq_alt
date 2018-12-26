// Global
$fn=90;

// Has to be a bit larger z wise due to the rengdering artefact
coil_size = [10, 2, 60];
// This version has 8 poles for the coils
coil_step = [0: 45: 360];
coil_grooves = [14, 8, 60];

// Stator (all in millimetres)
s_out_diameter = 180;
s_in_diameter = 160;

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

// Stator Definition
union() {
 difference() {
     cylinder( h=50, d=s_out_diameter, center=true );
     grooves( s_in_diameter, coil_step, coil_grooves );
     // rotate for angle that represents (5 + 8) mm
     // that is magnet y + coil groove y sizes
     rotate(-8.5) grooves( s_in_diameter, coil_step, coil_grooves );
     cylinder( h=50, d=s_in_diameter, center=true );
     holes( 18.6, [0: 90: 360], d=3, h=60 );
 }
}
