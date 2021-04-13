Extension { #name : #RMDApplyNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> evalIn: aRMDInterpreter [
	^ (aRMDInterpreter
		functionAt: function
		ifAbsent: [ ^ KeyNotFound signal: function , ' not found.' ])
		valueWithArguments: (arguments collect: [ :arg | arg evalIn: aRMDInterpreter ])
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> typecheckIn: aRMDInterpreter [
	^ [ [ (RMDFunction at: function)
		typecheckWithArguments: arguments
		in: aRMDInterpreter ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ] ]
		on: KeyNotFound
		do: [ :ex | ex resignalAs: (RMDUnresolvedReferenceError on: self) ]
]
