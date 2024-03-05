Extension { #name : #RMDFractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> evalIn: aRMDInterpreter [

	^ [ 
	  (expression1 evalIn: aRMDInterpreter)
	  / (expression2 evalIn: aRMDInterpreter) ifNanOrInfinite: [ 
		  RMDNotComputableError signal: self ] ]
		  on: ZeroDivide
		  do: [ :ex | ex resignalAs: (RMDNotComputableError on: self) ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> typecheckIn: aRMDInterpreter [

	^ type := (expression1 typecheckIn: aRMDInterpreter)
	          / (expression2 typecheckIn: aRMDInterpreter)
]
