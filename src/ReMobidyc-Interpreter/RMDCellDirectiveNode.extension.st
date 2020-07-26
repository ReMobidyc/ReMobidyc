Extension { #name : #RMDCellDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDCellDirectiveNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		cellDirective: directive
		variable: cellPropertyVariable
]
