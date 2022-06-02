Extension { #name : #RMDAgentInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentInitializerNode >> evalIn: aRMDInterpreter [
	attributeInitializers
		do: [ :initializer | initializer evalIn: aRMDInterpreter ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentInitializerNode >> typecheckIn: aRMDInterpreter [
	^ self subclassResponsibility
]
