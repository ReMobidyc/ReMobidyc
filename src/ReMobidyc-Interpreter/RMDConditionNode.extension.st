Extension { #name : #RMDConditionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDConditionNode >> evalIn: aRMDInterpreter [
	^ self subclassResponsibility
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDConditionNode >> typecheckIn: aRMDInterpreter [
	^ self subclassResponsibility
]
