# GENED 1125 PSET #3
# PROBLEM 1.2
# Ayush Noori

# load libraries
library(data.table)
library(purrr)
library(magrittr)
library(ggplot2)

# list all possible states and associated rewards
states = list(s1 = 7, s2 = 3, s3 = 5)

# for an epsilon-greedy agent, define epsilon and the initial states
simulate_agent = function(epsilon = 0.1, initial_state = "s2", verbose = F) { 
  
  # define vector to hold all states
  steps = c()
  
  # define initial state
  greedy = states[initial_state]
  steps[1] = names(greedy)
  
  # iterate over states
  for(i in 1:10) {
    
    # sample the uniform distribution
    probability = runif(1)
    
    # sample some random node as the next state
    if(probability <= epsilon) {
      
      # select potential next state
      if (verbose) message(">> Explore!")
      next_state = sample(states, 1)
      steps[i+1] = names(next_state)
      
      # message next state
      if (verbose) message("Step ", i, ": ", names(next_state), " (", next_state, ")")
      
      # check if next state is more rewarding
      if (next_state[[1]] > greedy[[1]]) {
        
        # update the greedy node
        greedy = next_state
        
      }
      
    } else { # visit the greedy node
      
      steps[i+1] = names(greedy)
      if (verbose) message("Step ", i, ": ", names(greedy), " (", greedy, ")")
      
    }
    
  }
  
  # return nodes
  return(steps)
  
}

# run 10 simulations
sim_epsilon = 0.9
sims = map(1:10, ~simulate_agent(epsilon = sim_epsilon, initial_state = "s2", verbose = F))

# visualize simulations
sims = map(sims, ~as.numeric(factor(.x, levels = names(states), labels = 1:3)))
# sim_sum = sum(map_lgl(sims, ~any(.x != 2)))
sims_df = map_dfr(1:length(sims), ~data.table(Simulation = .x, Step = 0:10, State = sims[[.x]]))

# create visualization
p = ggplot(sims_df, aes(x = Step, y = State, group = Simulation)) +
  geom_line(aes(color = Step), alpha = 0.2, size = 1.5) +
  ggtitle(bquote("Greedy-Epsilon Agent with" ~ epsilon == .(sim_epsilon))) +
  scale_colour_gradientn(colours = c("#eaac8b", "#e56b6f", "#b56576", "#6d597a", "#355070")) +
  scale_x_continuous(n.breaks = 11) +
  scale_y_continuous(breaks = 1:3, labels = c("S1", "S2", "S3")) +
  theme_bw() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold", size = 12),
    axis.text.y = element_text(size = 12),
    legend.position = "none"
  )

# save figure
dir = "Figures"
ggsave(file.path(dir, paste0("Greedy-Epsilon ", sim_epsilon, ".pdf")), p, width = 8, height = 6)
ggsave(file.path(dir, paste0("Greedy-Epsilon ", sim_epsilon, ".png")), p, width = 8, height = 6)
