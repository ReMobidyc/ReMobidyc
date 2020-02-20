Extension { #name : #RMDPropertyInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyInitializerNode >> evalIn: aRMDInterpreter [
	aRMDInterpreter
		initializeVariable: identifier
		with: (expression evalIn: aRMDInterpreter)
		ifAbsent: [ ^ KeyNotFound signal: identifier ]
]
