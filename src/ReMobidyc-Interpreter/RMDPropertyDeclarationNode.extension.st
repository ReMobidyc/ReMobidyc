Extension { #name : #RMDPropertyDeclarationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyDeclarationNode >> evalIn: aRMDInterpreter [
	^ expression evalIn: aRMDInterpreter
]
