// Global
$fn=90;

// Shaft for the high frequence alternator
// Likely should be made out of steel
// Units should be mm (at least for 3DHub case)
union() {
    cylinder( h=150, d=6, center=true );
    cube( size=[14,2,50], center=true );
    rotate(90) cube( size=[14,2,50], center=true );
}
