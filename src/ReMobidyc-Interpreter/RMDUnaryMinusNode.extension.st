Extension { #name : #RMDUnaryMinusNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUnaryMinusNode >> evalIn: aRMDInterpreter [
	^ (expression evalIn: aRMDInterpreter) negated
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUnaryMinusNode >> typecheckIn: aRMDInterpreter [

	^ type := expression typecheckIn: aRMDInterpreter
]
