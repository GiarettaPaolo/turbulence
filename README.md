# Turbulence
_From Navier-Stokes to Emerging Chaos_

All the unpredictable and poorly understood behavior of turbulent flow is contained in the (relatively) short deterministic Navier-Stokes equations. To study flow, we have to resort to statistical methods to predict key properties of the flow. Kolmogorov's K41 theory predicts how the flow energy is distributed across various length scales. The first part of this project concerns the study of the statistical properties of wall-grid-generated turbulence and its subsequent turbulent decay.

## Statistical Study of Turbulence Downstream a Grid
The experimental setup includes six anemometers positioned downstream of a turbulence-generating grid.

<div align="center">
  <img src="images/setup_anemometers.png" alt="Setup with 6 Anemometers" width="600"/>
</div>

We will plot the measurements collected from the anemometers to analyze the turbulence characteristics.

<div align="center">
  <img src="images/anemometer_measurements.png" alt="Anemometer Measurements" width="600"/>
</div>

Using Fast Fourier Transform (FFT) and interpolation, we can plot the energy spectrum to observe the K41 Kolmogorov energy cascade from the integral scale to the Kolmogorov scale, along with the turbulence decay energy at large scales.

<div align="center">
  <img src="images/energy_spectrum.png" alt="Energy Spectrum" width="600"/>
</div>

## Chaos of the Korteweg-de Vries (KdV) Equation
The KdV equation is a simple benchmark problem to understand chaos in a simplified setting.

<div align="center">
  <img src="images/kdv_equation.png" alt="KDV Equation" width="600"/>
</div>

This chaos can be quantified by Lyapunov exponents using an algorithm of successive normalization.

<div align="center">
  <img src="images/convergence.png" alt="Convergence of Lyapunov Exponents" width="600"/>
</div>

We are focused on finding periodic orbits in this highly chaotic attractor by running an optimization algorithm.

<div align="center">
  <img src="images/converged_orbits.png" alt="Converged Orbits" width="600"/>
</div>

For more details, look at the report.pdf!
