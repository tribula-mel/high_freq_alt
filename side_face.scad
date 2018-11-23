// Global
$fn=90;

// Stator (all in centrimetres)
s_out_diameter = 42;
s_in_diameter = 40;
// s_out_radius = r_out_diameter / 2 ;

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
    cylinder( h=3, d=s_out_diameter, center=true );
    cylinder( h=3, d=s_in_diameter, center=true );
    holes( 13.8, [0: 90: 360], d=0.4, h=6 );
 }

 difference() {
  union() {
    translate( [0, 0, 1.0]) cube( size = [40.1, 2, 1], center=true );
    translate( [0, 0, 1.0]) rotate(60) cube( size = [40.1, 2, 1], center=true );
    translate( [0, 0, 1.0]) rotate(120) cube( size = [40.1, 2, 1], center=true );
    // outer shell for the bearing
    cylinder( h=1, d=4, center=true );
  }
    // bearing dimensions Od=22mm, Width=9mm, Bore=8mm
    // http://www.skf.com/group/products/bearings-units-housings/ball-bearings/deep-groove-ball-bearings/deep-groove-ball-bearings/index.html?designation=608-2RSH
    cylinder( h=1, d=2.2, center=true );
    translate( [0, 0, 1.0] ) cylinder( h=1, d=0.8, center=true );
 }
}
