Extension { #name : #RMDApplyNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> evalIn: aRMDInterpreter [

	^ [ 
	  ((aRMDInterpreter
		    functionAt: function
		    ifAbsent: [ ^ RMDUndefinedFunctionError signal: self ]) 
		   valueWithArguments:
		   (arguments collect: [ :arg | arg evalIn: aRMDInterpreter ])) 
		  ifNanOrInfinite: [ RMDNotComputableError signal: self ] ]
		  on: ZeroDivide, ArithmeticError
		  do: [ :ex | ex resignalAs: (RMDNotComputableError on: self) ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> typecheckIn: aRMDInterpreter [

	| func |
	func := aRMDInterpreter
		        functionAt: function
		        ifAbsent: [ ^ RMDUndefinedFunctionError signal: self ].
	^ func
		  typecheckWithArguments: arguments
		  for: self
		  in: aRMDInterpreter
]
