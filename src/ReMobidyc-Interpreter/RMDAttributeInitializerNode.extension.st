Extension { #name : #RMDAttributeInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> evalIn: aRMDInterpreter [
	aRMDInterpreter
		initializeVariable: identifier
		with: (expression evalIn: aRMDInterpreter)
		ifAbsent: [ ^ KeyNotFound signal: identifier ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> typecheckIn: aRMDInterpreter [
	^ [ (aRMDInterpreter
		typeOfVariable: identifier
		agent: nil
		ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ])
		unify: (expression typecheckIn: aRMDInterpreter) ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
