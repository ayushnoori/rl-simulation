# Reinforcement Learning Simulations

Simulating epsilon-greedy and temporal difference reinforcement learning algorithms for [GENED 1125](https://gened1125.github.io/spring2022/) at [Harvard College](https://college.harvard.edu/).

## Epsilon-Greedy Exploration Policy

An agent which operates an epsilon-greedy policy will uniformly sample some random probability with ϵ probability and will select the greedy option (i.e., maximally-rewarding state of all previously explored states) with 1 - ϵ probability. Higher values of ϵ favor exploration over exploitation.

I simulate an epsilon-greedy agent in R, and visualize the results of 10 trials with ϵ = 0.1.

<img src="https://github.com/ayushnoori/rl-simulation/blob/main/Figures/Greedy-Epsilon%200.1.png" width="80%">

Next, I visualize the results of 10 trials with ϵ = 0.9.

<img src="https://github.com/ayushnoori/rl-simulation/blob/main/Figures/Greedy-Epsilon%200.9.png" width="80%">

## Temporal Difference Learning

The temporal difference (TD) learning equation is given by:

δ(t) = r(t) + γ⋅V(t+1) − V(t)

V(t) = V(t) + α⋅δ

Here, δ represents the TD error at time t while γ represents the discount factor.

I simulate temporal difference learning in R, and visualize the results of3 trials with α = 0.5 and γ = 0.9.

<img src="https://github.com/ayushnoori/rl-simulation/blob/main/Figures/TD%20Learning%20Simulation.png" width="80%">