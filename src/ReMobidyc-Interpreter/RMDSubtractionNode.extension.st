Extension { #name : #RMDSubtractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSubtractionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		- (expression2 evalIn: aRMDInterpreter)
]
