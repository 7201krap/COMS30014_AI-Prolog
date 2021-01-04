# Credit: Initial code was cloned from Project Mesa (https://github.com/projectmesa/mesa/tree/master/examples/schelling)

#######################################
# COMS30014 - Artificial Intelligence #
# Multiagent Systems Lab - II         #
# Schelling's Segregation Model       #
#######################################

# Before starting, make sure you have installed Mesa 
# You could install via command line --- pip install mesa
# For generating plots, you will need matplotlib which too you can install via command line --- pip install matplotlib


from mesa.visualization.ModularVisualization import ModularServer
from mesa.visualization.modules import CanvasGrid, ChartModule, TextElement
from mesa.visualization.UserParam import UserSettableParameter

from model import Schelling

class HappyElement(TextElement):
    """
    Display a text count of how many happy agents there are.
    """

    def __init__(self):
        pass

    def render(self, model):
        return "Happy agents: " + str(model.happy) + " Segregated agents: " + str(model.segregation) 


def schelling_draw(agent):
    """
    Portrayal Method for canvas
    """
    """
    Define the base potrayal. 
    A portrayal is a dictionary (which can easily be turned into a JSON object). 
    It tells the JavaScript side how to draw it.
    """
    if agent is None:
        return
    portrayal = {"Shape": "circle", "r": 0.8, "Filled": "true", "Layer": 0}

    
    """
    Change the color and stroke of the portrayal based on the type of the agent. 
    In this case, we will have red and blue agent.
    """
    if agent.type == 0:
        portrayal["Color"] = ["#FF0000", "#FF0000"]
        portrayal["stroke_color"] = "#00FF00"
        if agent.is_cooperative:
            portrayal["Color"] = ["#FF0000", "#0000FF"]  # Ref from outside; Blue from inside
            portrayal["stroke_color"] = "#FFFFFF"
            
        
    else:
        portrayal["Color"] = ["#0000FF", "#0000FF"]
        portrayal["stroke_color"] = "#000000"
        if agent.is_cooperative:
            portrayal["Color"] = ["#0000FF", "#FF0000"]  # Blue from outside; Red from inside
            portrayal["stroke_color"] = "#FFFFFF"
        
        
    return portrayal


# Initialize the Canvas and chart
happy_element = HappyElement()
canvas_element = CanvasGrid(schelling_draw, 30, 30, 450, 450)
happy_chart = ChartModule([{"Label": "happy", "Color": "Black"}, {"Label": "segregation", "Color": "Blue"}])

# Set the parameters for the model. UserSettableParameter means that the user can modify this parameter in the web page. It takes 6 parameters (type, name, initial value, min value, max value, value per step).
model_params = {
    "height": 30,
    "width": 30,
    "density": UserSettableParameter("slider", "Agent density", 0.9, 0.1, 1.0, 0.1),
    "minority_pc": UserSettableParameter(
        "slider", "Fraction minority", 0.5, 0.00, 1.0, 0.05
    ),
    "homophily": UserSettableParameter("slider", "Homophily", 3, 0, 8, 1),
    "cooperativeness": UserSettableParameter("slider", "Cooperativeness", 0.0, 0.0, 1.0, 0.01),
}

# Initialize the server with all the configurations defined above
server = ModularServer(
    Schelling, [canvas_element, happy_element, happy_chart], "Schelling", model_params
)