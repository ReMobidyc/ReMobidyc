# ReMobidyc
ReːMobidyc (or ReMobidyc without an exotic punctuation letter) is a web-based multi-agent simulator for individual-based modeling in population dynamics and ecotoxicology.

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

* Reproduceable random numbers
  - ReːMobidyc will have its own random number generator and make its code open so that all actions taken in a simulation can be accurately reproduceable.

* Web servers and APIs
  - ReːMobidyc will have web-based UI so that models can be shared by research communities.
  - ReːMobidyc will provide web API to retrieve models and simulation data so that anyone can create specialized native applications.
