Extension { #name : #RMDStageDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDStageDirectiveNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter changeStage: animatIdentifier
]
