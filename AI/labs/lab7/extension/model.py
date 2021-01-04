# Credit: Initial code was cloned from Project Mesa (https://github.com/projectmesa/mesa/tree/master/examples/schelling)

#######################################
# COMS30014 - Artificial Intelligence #
# Multiagent Systems Lab - II         #
# Schelling's Segregation Model       #
#######################################

# Before starting, make sure you have installed Mesa 
# You could install via command line --- pip install mesa
# For generating plots, you will need matplotlib which too you can install via command line --- pip install matplotlib


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

        # ANSWER
        self.is_cooperative = False
        # I added happiness_extent to convert
        # "homophily (wanted similarity) based on counting neighbors" to "percentage of similar neighbors"
        self.happiness_extent = 0
        # ANSWER

    # ANSWER
    def __init__(self, pos, model, agent_type, is_cooperative, happiness_extent):
        super().__init__(pos, model)
        self.pos = pos
        self.type = agent_type
        self.is_cooperative = is_cooperative
        self.happiness_extent = happiness_extent
        # ANSWER

    # 2 Step function
    def step(self):
        similar = 0
        neighbors = 0
        # 3 Calculate the number of similar neighbours
        for neighbor in self.model.grid.neighbor_iter(self.pos):
            # 자신과 같은 타입이거나, neighbor 가 is_cooperative = True 라면
            if neighbor.type == self.type or neighbor.is_cooperative:
                similar += 1
                # 자신 옆에 neighbor 가 몇개 있는지
            neighbors += 1  # ANSWER

        # ANSWER
        self.happiness_extent = 0
        if neighbors > 0:
            self.happiness_extent = similar / neighbors
        # ANSWER

        # 4 Move to a random empty location if unhappy
        if similar < self.model.homophily:
            self.model.grid.move_to_empty(self)
        else:
            self.model.happy += 1
        if similar == neighbors:
            self.model.segregation += 1


class Schelling(Model):
    """
    Model class for the Schelling segregation model.
    """

    # ANSWER --- cooperativeness = 10 in the init definition
    def __init__(self, height=30, width=30, density=0.9, homophily=3, cooperativeness=0.0):
        """
        """
        # Height and width of the Grid; 
        # Height and width also defines the maximum number of agents that could be in the environment
        self.height = height
        self.width = width

        # Define the population density; Float between 0 and 1
        self.density = density

        # number of similar neighbors required for the agents to be happy
        # Takes integer value between 0 and 8 since you can only be surrounded by 8 neighbors
        # homophily == wanted similarity
        self.homophily = homophily

        # ANSWER
        # 얼마만큼의 agent 를 cooperativeness 한 agent 로 정의 할 것인가
        self.cooperativeness = cooperativeness
        # ANSWER

        # Scheduler controls the order in which agents are activated
        self.schedule = RandomActivation(self)
        self.grid = SingleGrid(width, height, torus=True)

        self.happy = 0
        self.segregation = 0
        # Obtain data after each step
        self.datacollector = DataCollector(
            {"happy": "happy", "segregation": "segregation"},  # Model-level count of happy agents
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
                if self.random.random() < 0.33:
                    agent_type = 2
                elif self.random.random() > 0.66:
                    agent_type = 1
                else:
                    agent_type = 0

                # ANSWER
                is_cooperative = False
                if self.random.random() < cooperativeness:
                    is_cooperative = True

                happiness_extent = 0
                # ANSWER

                # ANSWER --- Updated initialization to use new init definition
                agent = SchellingAgent((x, y), self, agent_type, is_cooperative, happiness_extent)
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
        self.segregation = 0  # Reset counter of segregated agents
        self.schedule.step()
        # collect data
        self.datacollector.collect(self)

        # 여기서 terminate 하는거 manage
        if self.happy == self.schedule.get_agent_count():
            self.running = False
