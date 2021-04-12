Extension { #name : #RMDExpressionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDExpressionNode >> evalIn: aRMDInterpreter [
	^ self subclassResponsibility
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDExpressionNode >> typecheckIn: aRMDInterpreter [
	^ self subclassResponsibility
]
