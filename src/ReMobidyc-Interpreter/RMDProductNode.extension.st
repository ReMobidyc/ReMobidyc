Extension { #name : #RMDProductNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDProductNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		* (expression2 evalIn: aRMDInterpreter)
]
