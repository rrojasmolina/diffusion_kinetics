Read me file:

These codes solve numerically a diffuso-kinetic equation satisfied by the protein density \alpha. The evolution of \alpha induce shape transformation of the membrane. The codes are written in Matlab and allows to find the membrane shapes for each protein density. The solutions are found with the solver bvp4c.

I) The folder called "no_tension" deals with a system where the membrane has no surface tension. The solutions for \alpha and solutions of the shape equations for each time step are stored in a file, which are put in a folder named in function of the kinetic parameter K1. 

	INSIDE THE FOLDER NO_TENSION/H0=0.15/K1=9/ ONE FINDS THE FOLLOWING FILES: 

		1) K1_9.m computes the protein density and the shape associated to this density. This script uses files that contain the differential equations associated to the membrane energy minimization (shape equations) and the boundary conditions.

		2)plot_shapes.m plots the membrane shape at a given protein density in a plain 	color

		3)shapes3D.m plots the membrane shapes in 3D and colored according to the protein density

		4)r_and_neck_vs_t.m computes the vesicle radius and the vesicle neck width as a function of time

		5) z_time_dependence.m finds the maximal membrane height zmax as a function of time.

	INSIDE THE FOLDER NO_TENSION/H0 ONE FINDS THE FOLLOWING FILES:

		1) tcut_and_rbud_vs_K1.m finds the scission time (at which the membrane neck equals the membrane thickness) and the vesicle radius at that time

		2)r_est_vs_K1.m computes the estimated vesicle radius based on the average protein density and the spontaneous curvature of the proteins for each value of K1

		3)plot_shapes_tcut.m plots the membrane shapes at the scission time.

		4)plot_scaled_shapes.m plots the shapes after being rescaled with the estimated vesicle radius.

		5)scaled.m saves the radial coordinate and height scaled with the estimated vesicle radius.

	INSIDE THE FOLDER NO_TENSION ONE FINDS THE FOLLOWING FILES:

		1)plot_rbud.m plots the bud radius escalated with the estimated radius and a function of K1, for different values of H0.

		2)plot_scaled_shapes.m plots the scaled shapes for different values of H0 and K1

		3)plot_scission_time.m plots the scission time as function of K1 for different values of H0.


II) The folder called "tension" includes the surface tension. In this case one can fix the kinetic parameter K1 and H0 and change the surface tension.
	
	INSIDE THE FOLDER tension/K1=9/lambda=0.01 ONE FINDS:

		1)tension_guesses.m computes the shapes for the initial density for different values of lambda. These shapes are used to compute the shape evolution with the file lambda_001.m

		2)lambda_001.m computes the protein density and the associated membrane shapes for the surface tension lambda=0.01

		3)plot_shapes.m and z_time_dependence.m which do the same that was described above for the case of no tension

		     	
	
	INSIDE THE FOLDER tension/K1=9/ ONE FINDS:

		1)budding_time.m computes the budding time as a function of the surface tension based on the maximal height, as when the tension is not zero formation of very narrow necks is prevented in general

		2)plot_zmax.m plot zmax as a function of time.

