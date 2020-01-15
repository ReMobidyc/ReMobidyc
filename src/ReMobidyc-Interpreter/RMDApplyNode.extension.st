Extension { #name : #RMDApplyNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDApplyNode >> evalIn: aRMDInterpreter [
	^ (aRMDInterpreter
		functionAt: function
		ifAbsent: [ ^ KeyNotFound signal: function , ' not found.' ])
		valueWithArguments: (arguments collect: [ :arg | arg evalIn: aRMDInterpreter ])
]
