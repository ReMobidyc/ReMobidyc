Extension { #name : #RMDAssignableDeltaPropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDeltaPropertyVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDelta: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDeltaPropertyVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toDelta: self identifier
		  agent: anInteger
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDeltaPropertyVariableNode >> typecheckIn: aRMDInterpreter [
	^ propertyVariable typecheckIn: aRMDInterpreter
]
