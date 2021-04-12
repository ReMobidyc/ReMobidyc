Extension { #name : #RMDPropertyInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyInitializerNode >> evalIn: aRMDInterpreter [
	aRMDInterpreter
		initializeVariable: identifier
		with: (expression evalIn: aRMDInterpreter)
		ifAbsent: [ ^ KeyNotFound signal: identifier ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyInitializerNode >> typecheckIn: aRMDInterpreter [
	^ (aRMDInterpreter
		typeOfVariable: identifier
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal: identifier ])
		unify: (expression typecheckIn: aRMDInterpreter)
]
