# NACA-4digit-airfoil-generator

## Overview
MATLAB function to generate four-digit NACA airfoil geometries and exports its coordinates to a CAD-ready CVC file ready for aerodynamic analysis and manufacturing.


## Methodology
- Implemented analytical NACA 4-digit equations in MATLAB, utilizing different functions between the leading side and trailing side of airfoil.
- Generated upper and lower surface coordinates from thickness and chamber equations.
- Exported airfoil geometry as .csv file
- Integrated optional scaling factor for CAD unit compatibility

## Validation
Generated airfoils were compared against published NACA geometries, showing close agreement in chamber and thickness distrubtion. A check for calculating the maximum thickness normalized to chord length is within the code as a check for the maximum thickness within the NACA airfoil number.

## How to run
1. Opoen and run 'generate_naca4.m' in MATLAB
2. Input desired NACA designations (e.g., 2412), chord length, number of points, and optional scaling factor.
3. Output file will be saved in User's MATLAB folder.

## Applications
- CAD modeling
- Introductory aerodynamic analysis

## References: 
Introduction to Flight - Eigth Edition by John D. Anderson Jr. 
https://web.stanford.edu/~cantwell/AA200_Course_Material/The%20NACA%20airfoil%20series.pdf

