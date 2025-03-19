Extension { #name : 'RMDUtilityVariableNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDUtilityVariableNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter
		  readUtility: identifier
		  ifAbsent: [ RMDUndefinedUtilityError signal: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDUtilityVariableNode >> typecheckIn: aRMDInterpreter [

	^ type := aRMDInterpreter
		          typeOfUtilityVariable: identifier
		          ifAbsent: [ RMDUndefinedUtilityError signal: self ]
]
