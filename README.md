# Reinforcement Learning Simulations

Simulating epsilon-greedy and temporal difference reinforcement learning algorithms for [GENED 1125](https://gened1125.github.io/spring2022/) at [Harvard College](https://college.harvard.edu/).

## Epsilon-Greedy Exploration Policy

An agent which operates an epsilon-greedy policy will uniformly sample some random probability with $\epsilon$ probability and will select the greedy option (i.e., maximally-rewarding state of all previously explored states) with $1 - \epsilon$ probability. Higher values of $\epsilon$ favor exploration over exploitation.

I simulate an epsilon-greedy agent in R, and visualize the results of $n = 10$ trials with $\epsilon = 0.1$.

<img src="https://github.com/ayushnoori/rl-simulation/blob/main/Figures/Greedy-Epsilon%200.1.png" width="80%">

Next, I visualize the results of $n = 10$ trials with $\epsilon = 0.9$.

<img src="https://github.com/ayushnoori/rl-simulation/blob/main/Figures/Greedy-Epsilon%200.9.png" width="80%">

## Temporal Difference Learning

The temporal difference (TD) learning equation is given by:

$\delta(t) = r(t) + \gamma \cdot V(t+1) - V(t)$

$V_{new}(t) = V_{old}(t) + \alpha \cdot \delta$

Here, $\delta(t)$ represents the TD error at time $t$ while $\gamma$ represents the discount factor.

I simulate temporal difference learning in R, and visualize the results of $\alpha = 0.9$ trials with $\gamma = 0.9$.

<img src="https://github.com/ayushnoori/rl-simulation/blob/main/Figures/TD%20Learning%20Simulation.png" width="80%">