Extension { #name : #RMDUtilityVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUtilityVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readUtility: identifier
		ifAbsent: [ KeyNotFound signal ]
]
