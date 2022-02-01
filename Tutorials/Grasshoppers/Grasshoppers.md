# Build a simple Grashoppers model

This tutorial guides you to build a simple model with lifehisotry stages.

![Grasshopper model](Grasshoppers.png)

## 1. Open a modeller

In the menu bar, find "re:Mobidyc" submenu to select "Modeller".
![modeller](modeller-initial.png)

## 2. Define Cell

### the grass property

![add the grass property](add-grass-property-in-Cell.png)
![Cell definition with the grass property](grass-added.png)

### visualization

![Cell visualization](cell-visualization.png)

## 3. Define Grasshopper and Egg as Animats

### Grasshopper animat

![Add Grasshopper](create-Grasshopper.png)

### age property of Grasshopper

![Grasshopper definition](Grasshopper-initial.png)

![the age property of Grasshopper](Grasshopper-age-added.png)

### Egg animat

### age property of Egg

![Egg](Egg-age-added.png)

### visualization of Animats

![visualization of Egg](Egg-visualization.png)

## 4. Define the "grow" task of Cell

![task definition browser](task-definition-initial.png)

### the "gain" action

![gain action](import-gain-action.png)


### the "grow" task

![replacement](replacement.png)

![grow task](task-definition-grow.png)

![complete definition of cell](cell-defined.png)

## 5. Define tasks of Grasshopper

### the "age" action

![action editor](action-definition-initial.png)

![add property definition](action-property-definition.png)

![age action](age-action.png)

### the "age" task of Grasshopper

![age task](age-task.png)

### the "move" task

![move action](import-move-action.png)

![move specialization](move-specialization.png)

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

