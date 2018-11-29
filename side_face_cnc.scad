// Global
$fn=90;

// Stator (all in millimetres)
s_out_diameter = 180;
s_in_diameter = 160;

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

// Side Face Definition
union() {
 difference() {
    cylinder( h=20, d=s_out_diameter, center=true );
    cylinder( h=20, d=s_in_diameter, center=true );
    holes( 0, [0: 90: 360], d=3, h=60 );
    translate( [0, 0, -5] ) cylinder( h=10, d=(s_in_diameter+14), center=true);
 }

 difference() {
  union() {
    // translate to 20/2 (half of the cylinder height) - 5/2 (half of the cube height) along the z axis
    translate( [0, 0, 7.5]) cube( size = [160.1, 10, 5], center=true );
    translate( [0, 0, 7.5]) rotate(60) cube( size = [160.1, 10, 5], center=true );
    translate( [0, 0, 7.5]) rotate(120) cube( size = [160.1, 10, 5], center=true );
    // outer shell for the bearing
    translate( [0, 0, 20/2 - 16/2]) cylinder( h=16, d=30, center=true );
  }
    // bearing dimensions Od=22mm, Width=9mm, Bore=8mm
    // http://www.skf.com/group/products/bearings-units-housings/ball-bearings/deep-groove-ball-bearings/deep-groove-ball-bearings/index.html?designation=608-2RSH
    cylinder( h=12, d=22, center=true );
    translate( [0, 0, 10] ) cylinder( h=10, d=9, center=true );
 }
}
