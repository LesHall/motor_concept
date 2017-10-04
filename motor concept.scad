// by Les Hall
// started 3:04 am Sun Mar 29, 2015
// just got this idea for a boat motor or other motor
// from divine inspiration
// 


nozzle = 0.4;
motorOD = 75;
OD = 50;
k = 0.33;
ID = 25;
depth = 10;
numBlades = 3;
angle = 45;
magnetOD = 3/16 * 25.4;
play = 1;
thickness = 2;
$fn = 64;


// print in place motor!  
//
rotor();
stator();


// rotor lies inside of stator and prints in place
module rotor()
{
    // inside round
    difference()
    {
        intersection()
        {
            cylinder(d=1.25*ID, h=depth, center=true);
            
            rotate_extrude()
            translate([OD*k/2+ID/2-thickness, 0, 0])
            circle(d=OD*k);
        }

        rotate_extrude()
        translate([OD*k/2+ID/2, 0, 0])
        circle(d=OD*k);
    }
    
    // outside round
    difference()
    {
        intersection()
        {
            cylinder(d=1.25*OD, h=depth, center=true);
            
            rotate_extrude()
            translate([(1+k)/2*OD-thickness, 0, 0])
            circle(d=OD*k);
        }

        rotate_extrude()
        translate([(1+k)/2*OD, 0, 0])
        circle(d=OD*k);
    }
    
    // blades that push fluid
    intersection()
    {
        
        difference()
        {
            intersection()
            {
                cylinder(d=1.25*OD, h=depth, center=true);
            
                rotate_extrude()
                translate([OD*k/2+ID/2-thickness, 0, 0])
                circle(d=OD*k);
            }
    
            rotate_extrude()
            translate([(1+k)/2*OD, 0, 0])
            circle(d=OD*k);
        }
        
        // fan blades
        union()
        {
            for (i=[0:numBlades-1])
                rotate(360*i/numBlades, [0, 0, 1])
                rotate(angle, [1, 0, 0])
                translate([ID/2+(OD/2-ID/2)/2, 0, 0])
                // the blade
                cube([OD/2, thickness, 
                    2*(depth+thickness)*sin(angle)], 
                    center=true);
        }
    }
}



// holds rotor and coil in place
module stator()
{
    difference()
    {
        intersection()
        {
            // outer cylinder
            cylinder(d=1.25*(OD+2*nozzle+play+2*thickness), 
                h=depth, center=true);
            
            // torus defining inner shape
            rotate_extrude()
            translate([(1+k)/2*OD+2*nozzle+play, 0, 0])
            circle(d=OD*k);
        }
        
        // torus defining outer shape
        rotate_extrude()
        translate([(1+k)/2*OD+nozzle+2*play+thickness, 0, 0])
        circle(d=OD*k);
    }
}


