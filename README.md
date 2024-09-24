# Turbulence
_From Navier-Stokes to Emerging Chaos_

All the unpredictable and poorly understood behavior of turbulent flow is contained in the (relatively) short deterministic Navier-Stokes equations. To study flow, we have to resort to statistical methods to predict key properties of the flow. Kolmogorov's K41 theory predicts how the flow energy is distributed across various length scales. The first part of this project concerns the study of the statistical properties of wall-grid-generated turbulence and its subsequent turbulent decay.

## Statistical Study of Turbulence Downstream a Grid
The experimental setup includes six anemometers positioned downstream of a turbulence-generating grid. We will plot the measurements collected from the anemometers to analyze the turbulence characteristics.

<div align="center">
  <img src="Part 1/Plots/windTunnel.png" alt="Setup with 6 Anemometers" height="180"/>
  <img src="Part 1/Plots/plotAnemometers2.png" alt="Anemometer Measurements" height="180"/>
</div>

Using Fast Fourier Transform (FFT) and interpolation, we can plot the energy spectrum to observe the K41 Kolmogorov energy cascade from the integral scale to the Kolmogorov scale, along with the turbulence decay energy at large scales.

<div align="center">
  <img src="Part 1/Plots/energySpectrumDecay.png" alt="Energy Spectrum" width="800"/>
</div>

## Chaos of the Korteweg-de Vries (KdV) Equation
The KdV equation is a simple benchmark problem to understand chaos in a simplified setting.
The equation often serves as a simple benchmark for algorithms working on chaotic dynamics. 

<div align="center">
  <img src="Part 2/programs/Plots/equation.png" alt="KDV Equation" width="600"/>
</div>
<div align="center">
  <img src="Part 2/programs/Plots/spacetimecontours.png" alt="KDV Equation" width="600"/>
</div>

This chaos can be quantified by Lyapunov exponents using an algorithm of successive normalization. Notice how the more unpredictable system presents higher Lyapunov exponents. Similarl the Kaplan-York dimension quantifies the richness of dynamics. 

<div align="center">
  <img src="Part 2/programs/Plots/exponents1.png" alt="Convergence of Lyapunov Exponents" width="600"/>
</div>

We are focused on finding periodic orbits in this highly chaotic attractor by running an optimization algorithm.
The general trajectory of the dynamics in correspondence of the attractor shadows these converged periodic orbits temporarily, before switching to a different one.
Knowing the periodic orbits of the attractor may reveal statistical information of the chaotic dynamics (perhaps the same for turbulence one day!)

<div align="center">
  <img src="Part 2/programs/Plots/orbits1.png" alt="Converged Orbits" width="600"/>
</div>

## Details
For more details, look at the report.pdf for an in-depth discussion of the full problem!
