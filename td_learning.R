# GENED 1125 PSET #3
# PROBLEM 2.3
# Ayush Noori

# load libraries
library(data.table)
library(purrr)
library(magrittr)
library(ggplot2)
library(ggpubr)

# list all possible states and associated rewards
# rewards = list(r1 = 0, r2 = 0, r3 = 1)
rewards = c(rep(0, 5), 1)

# for an epsilon-greedy agent, define epsilon and the initial states
simulate_agent = function(alpha = 0.5, gamma = 0.9, trials = 3, verbose = F) { 
  
  # create environment matrix
  max_time = length(rewards)
  agent = data.table(Time = 1:max_time, R = unlist(rewards), TD = 0, V = 0)
  results = vector(mode = "list", length = trials)
  
  # iterate across trials
  for (i in 1:trials) {
    
    # iterate across time (i.e., states)
    for (t in 1:max_time) {
      
      # get next reward
      V_next = agent[t+1, V]
      if(is.na(V_next)) V_next = 0
      
      # calculate TD loss
      agent[t, TD := R + gamma*V_next - V]
      
      # update reward prediction
      agent[t, V := V + alpha*TD]
      
    }
    
    # append environment matrix
    if(verbose) message("\nTrial #", i); print(agent)
    results[[i]] = copy(agent)
    
  }
  
  return(results)
  
}

# run simulation
sim = simulate_agent(alpha = 0.5, gamma = 0.9, verbose = F, trials = 6)

# visualize simulation
sim_viz = imap(sim, ~{
  .x %>%
    # wide-to-long
    melt(id.vars = "Time") %>%
    .[, variable := factor(variable,
                           levels = c("R", "TD", "V"),
                           labels = c("Reward", "TD", "Prediction"))] %>%
    .[variable != "Reward"] %>%
    
    # data visualization
    ggplot(aes(x = Time, y = value, group = variable)) + 
    geom_bar(aes(fill = value), stat = "identity", color = "black", width = 0.7) +
    scale_fill_gradientn(colours = rev(c("#eaac8b", "#e56b6f", "#b56576", "#6d597a", "#355070"))) +
    scale_y_continuous(limits = 0:1, expand = expansion(c(0, 0.05))) +
    scale_x_continuous(breaks = 1:max(.x[, Time])) +
    ggtitle(paste0("Trial #", .y)) +
    facet_wrap(. ~ variable) +
    theme_bw() +
    theme(
      plot.title = element_text(face = "bold", size = 12),
      strip.text = element_text(face = "bold", size = 10),
      axis.title = element_blank(),
      legend.position = "none"
    )
})

# assemble plots
p = ggarrange(plotlist = sim_viz, ncol = 1)

# save plot
dir = "Figures"
ggsave(file.path(dir, "TD Learning Simulation.pdf"), p, width = 6, height = length(sim)*2)
ggsave(file.path(dir, "TD Learning Simulation.png"), p, width = 6, height = length(sim)*2)
