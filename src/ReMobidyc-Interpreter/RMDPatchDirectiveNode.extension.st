Extension { #name : #RMDPatchDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPatchDirectiveNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		patchDirective: directive
		variable: patchAttributeVariable
]
