Extension { #name : #RMDAssignablePropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignablePropertyVariableNode >> assign: aNumber in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toVariable: self identifier
		  agent: self agent
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignablePropertyVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toVariable: self identifier
		  agent: anInteger
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignablePropertyVariableNode >> typecheckIn: aRMDInterpreter [
	^ propertyVariable typecheckIn: aRMDInterpreter
]
