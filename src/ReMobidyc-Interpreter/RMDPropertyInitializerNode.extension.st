Extension { #name : #RMDPropertyInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyInitializerNode >> evalIn: aRMDInterpreter [
	aRMDInterpreter
		write: (expression evalIn: aRMDInterpreter)
		toVariable: identifier
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal: identifier ]
]
