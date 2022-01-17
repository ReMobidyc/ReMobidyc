[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
![CI](https://github.com/tomooda/ViennaTalk/actions/workflows/test.yml/badge.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cormas/cormas/master/LICENSE)

![logo-light1](images/logo-light1.png)

# re:mobidyc
reːmobidyc (or ReMobidyc without an exotic punctuation letter) is a web-based multi-agent simulator for individual-based modeling in population dynamics and ecotoxicology.

## Installation

Re:mobidyc is implemented on the [Pharo](https://pharo.org/) system.
There are two ways to install re:mobidyc.

### 1. from command shell

The following one-liner will download Pharo and install re:mobidyc.

```
curl https://raw.githubusercontent.com/ReMobidyc/ReMobidyc/main/scripts/install-remobidyc.sh | bash
```

### 2. from Pharo

If you have the [Pharo](https://pharo.org/) installation, you can install re:mobidyc by evaluating the following expression.

```
EpMonitor disableDuring: [
	Metacello new
		onConflictUseLoaded;
		onWarningLog;
		repository: 'github://ReMobidyc/ReMobidyc:main/';
		baseline: 'ReMobidyc';
		load ] 
```

## Example

### 1. Simplified SugarScape
![animation of sugascape example](images/SugarScape.png)

### 2. Goat and Wolf
![animation of goat and wolf example](images/GoatAndWolf.png)

## Background
Re:Mobidyc is a variation of Mobidyc that inherits the design rationale
of Mobidyc.
The objective of Re:Mobidyc is to renovate the original Mobidyc keeping
its design principles.
The base system is changed from VisualWorks to Pharo.
They are both Smalltalk systems, and Pharo is today's most actively
developed/used open-source Smalltalk system.
We will renovate the implementation of Mobidyc from its very basis to
apply outcomes from computer science.
The development of Re:Mobidyc is just beginning, and we will need time
to re-produce the functionality of the original Mobidyc.

[1] [The original Mobidyc site](https://mobidyc.cnrs.fr/index.php?title=English_summary)

## Design Rationale
As a tool for scientific research, ReːMobidyc will provide the following features

* Easy to model
  - A behavior of an agent will be defined in a declarative manner instead of series of commands, if-statements and loops.

* Easy to modify
  - Every component in a behavioral definition will be type-checked so that the user can find minor errors before running it.

* Easy to verify model
  - A definition can have assertions that double-checks its behavior so that the user can be sure that the model is defined as intended.

* Easy to reproduce
  - ReːMobidyc will make all simulation reproduceable including randomized actions.

* Easy to verify output
  - States of agents at every step in simulation will be stored in persistent memory so that the user and reviewers can check its validity.

* Easy to trace
  - The user can trace which agent had interaction with a particular agent to find the cause of an observed phenomenon. 

* Easy to publish
  - The user can publish her/his model along with input/intermediate/output data and visualized images as an evidence in scientific research.

* Easy to implement
  - ReːMobidyc will define its own modeling language in formal specification language so that its execution engine can be implemneted by third persons with complete compatibility.

## Architectural design
To achieve the objectives above, ReːMobidyc will have the following major components.

* Persistent storage
  - ReːMobidyc will use a DBMS as its persistent storage to store models, states of agents at all simulation steps, input data and output data.

* Reproducible random numbers
  - ReːMobidyc will have its own random number generator and make its code open so that all actions taken in a simulation can be accurately reproduceable.

* Web servers and APIs
  - ReːMobidyc will have web-based UI so that models can be shared by research communities.
  - ReːMobidyc will provide web API to retrieve models and simulation data so that anyone can create specialized native applications.
