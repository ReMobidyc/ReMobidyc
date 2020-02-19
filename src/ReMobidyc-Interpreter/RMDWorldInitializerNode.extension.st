Extension { #name : #RMDWorldInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> evalIn: aRMDInterpreter [
	propertyInitializers
		do: [ :initializer | initializer evalIn: aRMDInterpreter ]
]
