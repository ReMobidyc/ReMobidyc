Extension { #name : #RMDKillDirective }

{ #category : #'*ReMobidyc-Interpreter' }
RMDKillDirective >> evalIn: aRMDInterpreter [

	aRMDInterpreter terminate: 'object'
]
