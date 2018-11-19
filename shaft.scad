// Global
$fn=90;

// Shaft for the high frequence alternator
// Likely should be made out of steel
cylinder( h=15, d=0.6, center=true );
cube( size=[1.4,0.2,5], center=true );
rotate(90) cube( size=[1.4,0.2,5], center=true );