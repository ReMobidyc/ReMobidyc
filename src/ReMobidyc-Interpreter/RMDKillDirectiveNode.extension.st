Extension { #name : #RMDKillDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDKillDirectiveNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter terminate: 'object'
]
