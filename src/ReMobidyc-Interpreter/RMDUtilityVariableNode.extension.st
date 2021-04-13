Extension { #name : #RMDUtilityVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUtilityVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readUtility: identifier
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUtilityVariableNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter
		typeOfUtilityVariable: identifier
		ifAbsent: [ (RMDUnresolvedReferenceError on: self) signal ]
]
