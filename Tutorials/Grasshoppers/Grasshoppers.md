# Build a simple Grashoppers model

This tutorial guides you to build a simple model with lifehisotry stages.

<img alt="Grasshopper model" src="Grasshoppers.png">

## 1. Open a modeller

In the menu bar, find "re:Mobidyc" submenu to select "Modeller".

<img alt="modeller" src="modeller-initial.png" width=600>

## 2. Define Cell

We want grasshoppers fly to rich grass, so in this model each cell has the amount of grass as a property.
The unit of amount could be expressed in weight (such as `kg`), height (such as `cm`), or some other units.
In this model, we consider it's nutrition and use `kcal` to measure the amount of grass.

### the grass property

Cell initially does not have any property.
We first select Cell definition page by clicking at Cell tab.
Then we add the `grass` property to Cell by pressing the green '+' button and fill `grass` and `kcal` into Add property to Cell dialog.

<img alt="add the grass property" src="add-grass-property-in-Cell.png" width=600>

The Cell definition page will look as below.

<img alt="Cell definition with the grass property" src="grass-added.png" width=600>

### visualization

We want to visualize the amount of grass during the simulation.
The visualization can be set at the Visualization section of the Cell definition page.

<img alt="Cell visualization" src="cell-visualization.png" width=600>

Fill in `my grass` after the "with alpha =" label, and `0 [kcal]` and `100 [kcal]` into the following fields.
This visualization renders each cell with green blended with black background proportional to the cell's `grass` property.
When the grass is `0 [kcal]` the cell will look black, and `100 [kcal]` will color the cell in fully green.

## 3. Define Grasshopper and Egg as Animats

This model exhibits grasshoppers lay eggs and eggs become grasshopper when hatching.
Grasshopper and Egg are stages in lifehistory and are both modeled as Animat.

### Grasshopper animat

Selecting the green '+' tab will bring you the new animat page.

<img alt="Add Grasshopper" src="create-Grasshopper.png" width=600>

Type "Grasshopper" and then press the green "+" button on the right to create a new animat named `Grasshopper`.

### age property of Grasshopper

The `Grasshopper` tab brings you the definition page of the Grasshopper animat.
To judge maturity of grasshopper to lay eggs, we define the `age` property of the Grasshopper animat.

<img alt="Grasshopper definition" src="Grasshopper-initial.png" width=600>

Pressing the green "+" button below the Property list and type `age` and `[day]` to define the age property.

<img alt="the age property of Grasshopper" src="Grasshopper-age-added.png" width=600>

### Egg animat

We also have `Egg` as an animat.
Create it on the new animat page.

### age property of Egg

Again, define the `age` property in the same way as the one in `Grasshopper` animat.

<img alt="Egg" src="Egg-age-added.png" width=600>

### visualization of Animats

You can choose how to visualize the animat.
Select cyan in the Visualization section at the right top part of the `Egg` definition page.

<img alt="visualization of Egg" src="Egg-visualization.png" width=600>

## 4. Define the "grow" task of Cell

Now we are at the very core part of the model to define the behavior of each agent.
In re:mobidyc, the behavior of an agent is defined by tasks.
A task of an agent is tyically definitions of changes to properties of the agent, the cell where the agent is on, and optionally other agents within a given range.
For example, the `grow` task is to increase the value of the `grass` attribute of a cell.

Clicking at the green "plus" button below the Task list, the task definition browser will open.

<img alt="task definition browser" src="task-definition-initial.png" width=600>

### the "gain" action

To define a new task, we take two steps: (1) select or define an action, and then (2) specialize the action by providing the context of the situation to perform the task.
An action is a generalized template of the task.
For example, we want to define a `gain` task that increases the amount of the `grass`, which can be generalized as `gain` action because the `grass` in each cell will be gained.
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

Press the "OK" button and then the Cell definition page will look as follows.

<img alt="complete definition of cell" src="cell-defined.png" width=600>

## 5. Define tasks of Grasshopper

We will define five tasks of the `Grasshopper` animat, namely `age`, `move`, `eat`, starve`, and `lay_egg`.

### the "age" task of Grasshopper

We want to manage the maturity of a grasshopper in the `age` property.
Although it can be seen as a special case of `gain`, we define it as a user-defined action.

Clicking at the green "+" button below the Actions list will open an Action definition dialog.

<img alt="action editor" src="action-definition-initial.png" width=400>

In the position of `verb`, enter `age` which is the name of the action.
We then define the change definition on the `age` property.
Click at the green "+" button ABOVE the `where` label, and then the Property definition dialog will open.

<img alt="add property definition" src="action-property-definition.png" width=400>

Select `my` and Δ in the droplists, and enter `age` and `delta time`.
The `age` action will be defined as follows.

<img alt="age action" src="age-action.png" width=400>

We defined the `age` action very specific to our animat, and the resulting action does not need any specialization.
We simply select the `age` action and press the `OK` button in the task definition browser.

<img alt="age task" src="age-task.png" width=600>

### the "move" task

The `move` task takes a grasshopper to richer field, i.e. the cell with more `grass` property.
The re:mobidyc's built-in action repository provides the `move` action that allows you to specify the direction and the speed.
Click at the green "+" button at the task section to open the task definition browser.

First we import the `move` action from the built-in repository.
Click at the repository button at the action section to open the repository action browser, and select the built-in repository and the `move` action.

<img alt="import move action" src="import-move-action.png" width=600>

Then we specialize the `move` action to direct the grasshopper to richer field.
For `the direction`, we use `direction neighbor's grass` that gives the direction of the gradient of the `grass` attribute.
For `the speed`, we use `uniform 0 [m/day] to 500 [m/day]` that gives a random number from the uniform distribution between 0 and 500 m/day.

### the "eat" task

![lose action](import-lose-action.png)

![eat task](task-definition-eat.png)

### the "starve" task

![eat task](task-definition-starve.png)

### the "lay_egg" task

![lay_egg directives](directives-for-lay_egg.png)

![lay_egg action](action-definition-lay_egg.png)

![lay_egg task](task-definition-lay_egg.png)

## 6. Define tasks of Egg

![initial definition of Egg](Egg-definition-initial.png)

### the "age" task

![definition of age task of Egg](task-definition-age-Egg.png)

### the "hatch" task

![directives for hatch action](directive-for-hatch.png)

![stage directive](stage-directive.png)

![definition of hatch action](action-definition-hatch.png)

![definition of hatch task](task-definition-hatch.png)


## 7. Set up simulation

![initial time&space](time-space-definition.png)

### time

```during 1.0 year step by 1.0 day```

### Cell

```
10 x 10 of 1.0 km Cell with
  grass = uniform 0 [kcal] to 100 [kcal]
```

### Grasshopper

![choose animat](choose-animat-to-initialize.png)

```
10 Grasshopper with
  x = uniform 0 [m] to 10 [km]
  y = uniform 0 [m] to 10 [km]
  age = uniform 0 [day] to 30 [day]
```

![final simulation definition](simulation-definition.png)

## 8. Run the simulation

