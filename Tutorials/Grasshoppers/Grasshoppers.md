# Build a simple Grashoppers model

This tutorial guides you to build a simple model with lifehisotry stages.

<img alt="Grasshopper model" src="Grasshoppers.png">

## 1. Open a modeler

In the menu bar, find "re:Mobidyc" menu to select "Modeler (GUI)".

<img alt="modeller" src="modeler-initial.png" width=600>

## 2. Define Patch

We want grasshoppers fly to rich grass, so in this model each patch has the amount of grass as an attribute.
The unit of amount could be expressed in weight (such as `kg`), height (such as `cm`), or some other units.
In this model, we consider it's nutrition and use `kcal` to measure the amount of grass.

### the grass attribute

Select the 'Patch' tab in the modeler to edit the definition of Patch.

The attribute definitions of the Patch agent is listed in the upper left list of the Patch page.
The list is initially empty because Patch initially has no attribute.
We will add the `grass` attribute to Patch.

First, click the green '+' button below the attribute list to add a new definition.
The newly added definition is empty and incomplete as indicated by the red triangle at the head column of the row.
Enter 'grass' into the name column, 'kcal' to the unit column, and 'uniform 0 [kcal] to 100 [kcal]' to the initial value column.

The Patch definition page will look as below.

<img alt="add the grass attribute" src="add-grass-attribute-in-Patch-filled.png" width=600>

### visualization

We want to visualize the amount of grass during the simulation.
The visualization can be set at the Visualization section of the Patch definition page.

Fill in `my grass` after the "with alpha =" label, and `0 [kcal]` and `100 [kcal]` into the following fields.
This visualization renders each patch with green blended with black background proportional to the patch's `grass` attribute.
When the grass is `0 [kcal]` the patch will look black, and `100 [kcal]` will color the patch in fully green.

<img alt="Patch visualization" src="patch-visualization.png" width=600>

## 3. Define Grasshopper as a species with Adult and Egg stages

This model exhibits grasshoppers lay eggs and eggs become adults by hatching.
Adult and Egg are life-history stages and are both modeled as Animat.

### Adult animat

Selecting the green '+' tab will bring you the new animat page.
Type "Grasshopper" as the new species name and "Adult" as the stage name.
Then, press the green "+" button on the right to create a new animat named `Adult`.

<img alt="Add Grasshopper" src="create-Grasshopper.png" width=600>

### age attribute of Grasshopper

The `Grasshopper` tab brings you the definition page of the Grasshopper animat.
To judge maturity of grasshopper to lay eggs, we define the `age` attribute of the Grasshopper animat.

<img alt="Grasshopper definition" src="Grasshopper-initial.png" width=600>

Pressing the green "+" button below the Attribute list and type `age` in the name column, `[day]` in the unit column, and `0 [day]` in the initial value column to define the age attribute.

<img alt="the age attribute of Grasshopper" src="Grasshopper-age-added.png" width=600>

### Egg animat

We also have `Egg` as an animat.
Create it on the new animat page.

### age attribute of Egg

Again, define the `age` attribute in the same way as the one in `Grasshopper` animat.

<img alt="Egg" src="Egg-age-added.png" width=600>

### visualization of Animats

You can choose how to visualize the animat.
Select cyan in the Visualization section at the right top part of the `Egg` definition page.

<img alt="visualization of Egg" src="Egg-visualization.png" width=600>

## 4. Define the "grow" task of Patch

Now we are at the very core part of the model to define the behavior of each agent.
In re:mobidyc, the behavior of an agent is defined by tasks.
A task of an agent is tyically definitions of changes to properties of the agent, the patch where the agent is on, and optionally other agents within a given range.
For example, the `grow` task is to increase the value of the `grass` attribute of a patch.

Clicking at the green "plus" button below the Task list, the task definition browser will open.

<img alt="task definition browser" src="task-definition-initial.png" width=600>

### the "gain" action

To define a new task, we take two steps: (1) select or define an action, and then (2) specialize the action by providing the context of the situation to perform the task.
An action is a generalized template of the task.
For example, we want to define a `gain` task that increases the amount of the `grass`, which can be generalized as `gain` action because the `grass` in each patch will be gained.
In the re:mobidyc, several actions, including the `gain` action`, are provided in the built-in repository.

Clicking at the left-most button with a repository icon, the repository action browser will open.
Select `built-in` in the repository list on the left, and then `gain` in the upper-right list.
The source definition will be shown below the list.

<img alt="gain action" src="import-gain-action.png" width=600>

`the` denotes placeholders which will be replaced later in the definition of tasks.
This action contains three placeholders: `the thing`, `the maximum`, and `the amount`.

The line `when the thing < the maximum` declares the condition to perform this action.
If this condition is not satisfied, tasks based on this action will not be performed.

`the Δthing' = amount` defines the main effect of this action that the value of `the thing` will be increased by `amount`.
The value of `amount` is defined in the `where` clause.

### the "grow" task

The `grow` task can be defined as a specialization of the `gain` action by replacing the placeholders.
The replacement are defined in the Task specialization section.
Clicking at the green "+" button at the bottom of the Task specialization section will open the replacement dialog.

<img alt="replacement" src="replacement.png" width=600>

Select `the` at the first droplist, type `thing` before the left arrow, and enter `here's grass` so that the whole thing will read as `the thing -> here's grass`.
Add `the maximum -> 100 [kcal]` and `the amount -> 1 [kcal/day] * delta time`.
Please note that if you enter `delta`, the system will translate it into the `Δ` symbol.

The task definition will look as follows.

<img alt="grow task" src="task-definition-grow.png" width=600>

Press the "OK" button and then the Patch definition page will look as follows.

<img alt="complete definition of patch" src="patch-defined.png" width=600>

## 5. Define tasks of Grasshopper

We will define five tasks of the `Grasshopper` animat, namely `age`, `move`, `eat`, `starve`, and `lay_egg`.

### the "age" task of Grasshopper

We want to manage the maturity of a grasshopper in the `age` attribute.
Although it can be seen as a special case of `gain`, we define it as a user-defined action.

Select the `Grasshopper` tab and click at the green "+" button at the tasks section to open the task definition browser.
Clicking at the green "+" button below the Actions list will open an Action definition dialog.

<img alt="action editor" src="action-definition-initial.png" width=400>

In the position of `verb`, enter `age` which is the name of the action.
We then define the change definition on the `age` attribute.
Click at the green "+" button ABOVE the `where` label, and then the Attribute definition dialog will open.

<img alt="add attribute definition" src="action-attribute-definition.png" width=400>

Select `my` and Δ in the droplists, and enter `age` and `delta time`.
The `age` action will be defined as follows.

<img alt="age action" src="age-action.png" width=400>

We defined the `age` action very specific to our animat, and the resulting action does not need any specialization.
We simply select the `age` action and press the `OK` button in the task definition browser.

<img alt="age task" src="age-task.png" width=600>

### the "move" task

The `move` task takes a grasshopper to richer field, i.e. the patch with more `grass` attribute.
The re:mobidyc's built-in action repository provides the `move` action that allows you to specify the direction and the speed.
Click at the green "+" button at the task section to open the task definition browser.

First we import the `move` action from the built-in repository.
Click at the repository button at the action section to open the repository action browser, and select the built-in repository and the `move` action.

<img alt="import move action" src="import-move-action.png" width=600>

Then we specialize the `move` action to direct the grasshopper to richer field.
For `the direction`, we use `direction neighbor's grass` that gives the direction of the gradient of the `grass` attribute.
For `the speed`, we use `uniform 0 [m/day] to 500 [m/day]` that gives a random number from the uniform distribution between 0 and 500 m/day.

### the "eat" task

In this mode, the `eat` task consumes the grass in the field.
So, we can define the `eat` task using the `lose` action provided in the built-in repository.

First, select the `Grasshopper` tab and click at the green "+" button at the tasks section to open the task definition browser.
Import the `lose` action using the repository button in the action section.

<img alt="import lose action" src="import-lose-action.png" width=600>

Then we specialize the `lose` action into the `eat` task.
First, enter `eat` under the Task Specialization label instead of lose.
Then provide the following replacements.

```
the thing -> here's grass
the minimum -> 0 [kcal]
the amount -> 1 [kcal/day] * delta time
```

This will have a grasshopper eat the grass at the rate of 1 [kcal/day] unless the grass is below `0 [kcal]`.
The resulting task definition will look as below.

<img alt="eat task" src="task-definition-eat.png" width=600>

### the "starve" task

In this model, a grasshopper dies when the field has no food to eat (namely grass).                
The `starve` action is provided in the built-in repository and we can give the following replacements.

```
the vitality -> here's grass
the minimum -> 1 [kcal]
```
The resulting `starve` task will look as follows.

<img alt="eat task" src="task-definition-starve.png" width=600>

### the "lay_egg" task

Reproduction is not a mere change to properties but generate one or more new individuals into the simulation.
Such actions can be defined using the `new` lifehistory directive.
In this particular model, a grasshopper dies when it lay eggs.
Death can be implemented by the `die` lifehistory directive.

Select the `Grasshopper` tab and click at the green "+" button at the tasks section to open the task definition browser.
Clicking at the green "+" button below the Actions list will open an Action definition dialog.

<img alt="action editor" src="action-definition-initial.png" width=400>

Then press the button labelled `no directive` to choose lifehistory directives.

<img alt="lay_egg directives" src="directives-for-lay_egg.png" width=400>

Check "die" and "new", and press OK.
Then you'll be asked to enter the Animat name, but leave it as it is and press OK again.

<img alt="lay_egg action definition" src="action-definition-lay_egg.png" width=400>

First, enter `lay_egg` at the first field to name the action.
Then, enter `my agen > 50 [day]` to specify the condition that this action should be taken.
We also need to define a attribute definition to reset the `age` attribute of the new eggs.
Click the green "+" button above the "where" label and select `new` and enter `age` and `0 [day]` to make `new age' = 0 [day]`.
Press OK to accept the new definition of the `lay_egg` task.

Then, we can specialize the `lay_egg` action so that it generates five new eggs.
Click the green "+" button at the Task specialization section to give a replacement `new - -> new 5 Egg`.
Press OK to finish the definition.

<img alt="lay_egg task" src="task-definition-lay_egg.png" width=600>

## 6. Define tasks of Egg

Now we define two tasks of Egg, namely `age` and `hatch`.
We start with the Egg definition page as below.

<img alt="initial definition of Egg" src="Egg-definition-initial.png" width=600>

### the "age" task

The `age` task of the `Egg` animat is same as the `Grasshopper` animat's.
Open the task definition browser by clicking at the green "+" button below the task list.
Then, select the `age` action that we defined before and press the OK button to accept the definition.

<img alt="definition of age task of Egg" src="task-definition-age-Egg.png" width=600>

### the "hatch" task

The `hatch` task transitions the lifehistory stage from `Egg` to `Grasshopper`.
The transition is performed by the `stage` lifehistory directive.

Open the action definition editor by clicking at the green "+" button at the Actions list of the task definition browser.
Press the directive button labelled "no directive" and check the `stage` directive.

<img alt="directives for hatch action" src="directive-for-hatch.png" width=400>

You'll be asked for the animat when you press OK button.
Type `Grasshopper` and press OK to tell that an egg will become a grasshopper by the `hatch` task.

<img alt="stage directive" src="stage-directive.png" width=400>

We want the egg to hatch after 20 days.
This can be specified in the "when" clause as `my age > 20 [day]`.
Then the action definition will look as below.

<img alt="definition of hatch action" src="action-definition-hatch.png" width=400>

Press OK button, and the task definition of the `hatch` task will look as below.

<img alt="definition of hatch task" src="task-definition-hatch.png" width=600>


## 7. Set up simulation

So far we have defined the model. Now we can define the simulation settings including the initial conditions of agents.
Select the `Time & Space` page to set up the simulation settings.

<img alt="initial time&space" src="time-space-definition.png" width=600>

### time

The first line defines the length and time step of the simulation.
Please set as the following.

```during 1.0 year step by 1.0 day```

### Patch

The second and the third lines specify the structure of the space and initial values of the `grass` attribute.
Please set as the following.

```
10 x 10 of 1.0 km Patch with
  grass = uniform 0 [kcal] to 100 [kcal]
```

### Grasshopper

We need to place several grasshoppers and/or eggs.
This time, we place 10 grasshoppers at the random positions with random ages (0-30 days old)

To place Animat, press the green "+" button to append an animat initialization.
You'll be asked which animat you want to initialize, and you will answer `Grasshopper`.

<img alt="choose animat" src="choose-animat-to-initialize.png" width=400>

Then you can define the initializer as follows.

```
10 Grasshopper with
  x = uniform 0 [m] to 10 [km]
  y = uniform 0 [m] to 10 [km]
  age = uniform 0 [day] to 30 [day]
```

Now the `Time & Space` page will look as below.

<img alt="final simulation definition" src="simulation-definition.png" width=600>

## 8. Run the simulation

Pressing "Run" button will open the Observatory.

<img alt="Observatory" src="Observatory-initial.png" width=600>

Enjoy animation by clicking the Run button at the top.
You can see the resulting data in forms of tables and charts.
You can also save the animation as APNG by clicking the camera icon on the right.
(Recording APNG takes for a while.)
