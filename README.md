# NetLogo Predator-Prey Ecosystem Model

![NetLogo](http://ccl.northwestern.edu/images/creativecommons/byncsa.png)

## Table of Contents

- [What is it?](#what-is-it)
- [How It Works](#how-it-works)
- [How to Use It](#how-to-use-it)
- [Things to Notice](#things-to-notice)
- [Things to Try](#things-to-try)
- [Extending the Model](#extending-the-model)
- [NetLogo Features](#netlogo-features)
- [Related Models](#related-models)
- [Credits and References](#credits-and-references)
- [How to Cite](#how-to-cite)
- [Copyright and License](#copyright-and-license)

## What is it?

This NetLogo model explores the stability of predator-prey ecosystems. A predator-prey ecosystem can be categorized as unstable if it is prone to the extinction of one or more species within it. Conversely, a system is considered stable when it can persist over time, even in the presence of fluctuations in population sizes.

## How It Works

This model offers two main variations:

1. **Sheep-Wolves Variation**: In this variation, wolves and sheep roam randomly on a landscape. Wolves actively seek sheep to prey on. Wolves expend energy with each step, and they must consume sheep to replenish their energy. When wolves run out of energy, they die. Both wolves and sheep have a fixed probability of reproducing at each time step. In this variation, the grass is treated as "infinite," ensuring that sheep always have enough to eat. Sheep do not gain or lose energy through eating or moving. This variation is interesting but ultimately unstable and is suitable for modeling interactions in a nutrient-rich environment.

2. **Sheep-Wolves-Grass Variation**: In this version, grass (depicted in green) is explicitly modeled alongside wolves and sheep. Wolves' behavior is identical to the first variation. However, in this scenario, sheep need to consume grass to maintain their energy; otherwise, they die when they run out of energy. After grass is eaten, it regrows after a fixed amount of time. This variation is more complex but generally stable. It aligns more closely with the classic Lotka-Volterra population oscillation models, providing more realistic results, especially for small populations.

The model's construction is detailed in two papers by Wilensky & Reisman (1998; 2006), as referenced below.

## How to Use It

1. Choose the model version by setting the "MODEL-VERSION" chooser to either "sheep-wolves-grass" for the version with grass or "sheep-wolves" for the version without grass.
2. Adjust the slider parameters (as described below) or use the default settings.
3. Click the "SETUP" button.
4. Click the "GO" button to initiate the simulation.
5. Monitor the population sizes using the displayed monitors.
6. Observe the POPULATIONS plot to track population fluctuations over time.

**Parameters:**
- **MODEL-VERSION**: Choose between sheep-wolves and sheep-wolves-grass.
- **INITIAL-NUMBER-SHEEP**: Initial sheep population size.
- **INITIAL-NUMBER-WOLVES**: Initial wolf population size.
- **SHEEP-GAIN-FROM-FOOD**: Amount of energy sheep gain for each grass patch eaten (not used in the sheep-wolves version).
- **WOLF-GAIN-FROM-FOOD**: Amount of energy wolves gain for each sheep eaten.
- **SHEEP-REPRODUCE**: Probability of a sheep reproducing at each time step.
- **WOLF-REPRODUCE**: Probability of a wolf reproducing at each time step.
- **GRASS-REGROWTH-TIME**: Time it takes for grass to regrow once it is eaten (not used in the sheep-wolves version).
- **SHOW-ENERGY?**: Toggle to display the energy level of each animal as a number.

**Notes:**
- In the sheep-wolves model variation, one unit of energy is deducted for every step a wolf takes.
- In the sheep-wolves-grass model variation, one unit of energy is deducted for every step a sheep takes.

The model includes three monitors for tracking the populations of wolves, sheep, and grass, as well as a populations plot to visualize population changes over time. If there are no wolves left and an excessive number of sheep, the model run stops.

## Things to Notice

- In the sheep-wolves model variation, observe how the sheep and wolf populations fluctuate. Pay attention to the relationship between increases and decreases in the sizes of each population. What patterns emerge, and what ultimately happens?

- In the sheep-wolves-grass model variation, take note of the green line on the population plot, representing fluctuations in the amount of grass. How do the sizes of the three populations appear to relate now, and what explains these relationships?

- Why do you think some variations of the model are stable while others are not?

## Things to Try

- Experiment with adjusting the parameters under various settings. How sensitive is the stability of the model to specific parameter values?

- Can you identify parameter combinations that result in a stable ecosystem in the sheep-wolves model variation?

- Try running the sheep-wolves-grass model variation but set INITIAL-NUMBER-WOLVES to 0. This creates a stable ecosystem with only sheep and grass. What might explain the stability of this variation compared to the one with only sheep and wolves?

- Under stable settings, observe that populations tend to fluctuate at a predictable pace. Can you find any parameters that accelerate or decelerate these fluctuations?

## Extending the Model

There are several ways to modify the model to achieve stability with only wolves and sheep (without grass). Some modifications may require coding new elements or changing existing behaviors. Can you develop such a version?

Consider changing the reproduction rules. For instance, what would happen if reproduction depended on energy levels rather than a fixed probability?

Explore modifications to make sheep exhibit flocking behavior.

Explore modifications to make wolves actively chase sheep.

## NetLogo Features

- **Breeds** are used to model two types of "turtles": wolves and sheep.
- **Patches** are used to represent grass.
- **ONE-OF** agentset reporter is used to select a random sheep for consumption by a wolf.

## Related Models

Check out the "Rabbits Grass Weeds" model for another example of interacting populations with different rules.

## Credits and References

- Wilensky, U. & Reisman, K. (1998). Connected Science: Learning Biology through Constructing and Testing Computational Theories -- an Embodied Modeling Approach. International Journal of Complex Systems, M. 234, pp. 1 - 12.
- Wilensky, U. & Reisman, K. (2006). Thinking like a Wolf, a Sheep or a Firefly: Learning Biology through Constructing and Testing Computational Theories -- an Embodied Modeling Approach. Cognition & Instruction, 24(2), pp. 171-209. [Read the paper](http://ccl.northwestern.edu/papers/wolfsheep.pdf).
- Wilensky, U., & Rand, W. (2015). An introduction to agent-based modeling: Modeling natural, social and engineered

 complex systems with NetLogo. Cambridge, MA: MIT Press.
- Lotka, A. J. (1925). Elements of physical biology. New York: Dover.
- Volterra, V. (1926, October 16). Fluctuations in the abundance of a species considered mathematically. Nature, 118, 558–560.
- Gause, G. F. (1934). The struggle for existence. Baltimore: Williams & Wilkins.

## How to Cite

If you mention this model or the NetLogo software in a publication, please include the following citations:

For the model itself:
- Wilensky, U. (1997). NetLogo Wolf Sheep Predation model. [Model Link](http://ccl.northwestern.edu/netlogo/models/WolfSheepPredation). Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

For the NetLogo software:
- Wilensky, U. (1999). NetLogo. [NetLogo Link](http://ccl.northwestern.edu/netlogo/). Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

## Copyright and License

- Copyright 1997 Uri Wilensky.
- This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License. To view a copy of this license, visit [here](https://creativecommons.org/licenses/by-nc-sa/3.0/) or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
- Commercial licenses are also available. For inquiries about commercial licenses, please contact Uri Wilensky at uri@northwestern.edu.
- This model was created as part of the project: CONNECTED MATHEMATICS: MAKING SENSE OF COMPLEX PHENOMENA THROUGH BUILDING OBJECT-BASED PARALLEL MODELS (OBPML). The project acknowledges the support of the National Science Foundation (Applications of Advanced Technologies Program) with grant numbers RED #9552950 and REC #9632612.
- This model was converted to NetLogo as part of the projects: PARTICIPATORY SIMULATIONS: NETWORK-BASED DESIGN FOR SYSTEMS LEARNING IN CLASSROOMS and/or INTEGRATED SIMULATION AND MODELING ENVIRONMENT. The project acknowledges the support of the National Science Foundation (REPP & ROLE programs) with grant numbers REC #9814682 and REC-0126227. Converted from StarLogoT to NetLogo in 2000.

---

For further information and to access the model, please visit the [NetLogo Wolf Sheep Predation model](http://ccl.northwestern.edu/netlogo/models/WolfSheepPredation) on the Center for Connected Learning and Computer-Based Modeling, Northwestern University's website.
