Extension { #name : #RMDApplyNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> evalIn: aRMDInterpreter [

	^ (aRMDInterpreter
		   functionAt: function
		   ifAbsent: [ ^ RMDUndefinedFunctionError signal: self ]) 
		  valueWithArguments:
		  (arguments collect: [ :arg | arg evalIn: aRMDInterpreter ])
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> typecheckIn: aRMDInterpreter [

	| func |
	func := RMDFunction
		        at: function
		        ifAbsent: [ ^ RMDUndefinedFunctionError signal: self ].
	^ func
		  typecheckWithArguments: arguments
		  for: self
		  in: aRMDInterpreter
]
