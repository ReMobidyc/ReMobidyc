Extension { #name : #RMDProductNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDProductNode >> evalIn: aRMDInterpreter [

	^ (expression1 evalIn: aRMDInterpreter)
	  * (expression2 evalIn: aRMDInterpreter) ifNanOrInfinite: [ 
		  RMDNotComputableError signal: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDProductNode >> typecheckIn: aRMDInterpreter [

	^ (expression1 typecheckIn: aRMDInterpreter)
	  * (expression2 typecheckIn: aRMDInterpreter)
]
