Extension { #name : #RMDUnaryMinusNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUnaryMinusNode >> evalIn: aRMDInterpreter [
	^ (expression evalIn: aRMDInterpreter) negated
]
