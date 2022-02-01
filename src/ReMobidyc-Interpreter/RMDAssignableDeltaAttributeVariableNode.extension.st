Extension { #name : #RMDAssignableDeltaAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDeltaAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDelta: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDeltaAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toDelta: self identifier
		  agent: anInteger
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDeltaAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ attributeVariable typecheckIn: aRMDInterpreter
]
