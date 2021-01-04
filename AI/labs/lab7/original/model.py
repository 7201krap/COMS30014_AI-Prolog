#######################################
# COMS30014 - Artificial Intelligence #
# Multiagent Systems Lab - II         #
# Schelling's Segregation Model       #
#######################################

# Before starting, make sure you have installed Mesa 
# You could install via command line --- pip install mesa
# For generating plots, you will need matplotlib which too you can install via command line --- pip install matplotlib

# Credit: This code is cloned from Project Mesa (https://github.com/projectmesa/mesa/tree/master/examples/schelling)

from mesa import Model, Agent
from mesa.time import RandomActivation
from mesa.space import SingleGrid
from mesa.datacollection import DataCollector


class SchellingAgent(Agent):
    # 1 Initialization
    def __init__(self, pos, model, agent_type):
        super().__init__(pos, model)
        self.pos = pos
        self.type = agent_type
        self.pc_happy = 0

    # 2 Step function
    def step(self):
        similar = 0
        # 3 Calculate the number of similar neighbours
        for neighbor in self.model.grid.neighbor_iter(self.pos):
            if neighbor.type == self.type:
                similar += 1

        # 4 Move to a random empty location if unhappy
        if similar < self.model.homophily:
            self.model.grid.move_to_empty(self)
        else:
            self.model.happy += 1

class Schelling(Model):
    """
    Model class for the Schelling segregation model.
    """

    def __init__(self, height=30, width=30, density=0.9, minority_pc=0.5, homophily=3):
        """
        """
        # Height and width of the Grid; 
        # Height and width also defines the maximum number of agents that could be in the environment
        self.height = height
        self.width = width
        
        # Define the population density; Float between 0 and 1
        self.density = density
        
        # Ratio between blue and red. 
        # Blue is minority, red is majority; Float between 0 and 1; if > 0.5, blue becomes majority
        # 1 에 가까워 질수록 파란색이 많아지고,
        # 0 에 가까워 질수록 빨간색이 많아진다.
        self.minority_pc = minority_pc
        
        # number of similar neighbors required for the agents to be happy
        # Takes integer value between 0 and 8 since you can only be surrounded by 8 neighbors
        self.homophily = homophily

        # Scheduler controls the order in which agents are activated
        self.schedule = RandomActivation(self)
        self.grid = SingleGrid(width, height, torus=True)

        self.happy = 0
        # Obtain data after each step
        self.datacollector = DataCollector(
            {"happy": "happy"},  # Model-level count of happy agents
            # For testing purposes, agent's individual x and y
            {"x": lambda a: a.pos[0], "y": lambda a: a.pos[1]},
        )

        # Set up agents
        # We use a grid iterator that returns
        # the coordinates of a cell as well as
        # its contents. (coord_iter)
        for cell in self.grid.coord_iter():
            x = cell[1]
            y = cell[2]
            if self.random.random() < self.density:
                if self.random.random() < self.minority_pc:
                    agent_type = 1
                else:
                    agent_type = 0

                agent = SchellingAgent((x, y), self, agent_type)
                self.grid.position_agent(agent, (x, y))
                self.schedule.add(agent)

        self.running = True
        self.datacollector.collect(self)

    # The class requires a step function that represent each run
    def step(self):
        """
        Run one step of the model. If All agents are happy, halt the model.
        """
        self.happy = 0  # Reset counter of happy agents
        self.schedule.step()
        # collect data
        self.datacollector.collect(self)

        # 여기서 terminate 하는 것을 manage 한다.
        if self.happy == self.schedule.get_agent_count():
            self.running = False