Extension { #name : 'RMDPowerNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDPowerNode >> evalIn: aRMDInterpreter [

	^ (expression evalIn: aRMDInterpreter) ** order ifNanOrInfinite: [ 
		  RMDNotComputableError signal: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDPowerNode >> typecheckIn: aRMDInterpreter [

	^ type := (expression typecheckIn: aRMDInterpreter) ** order
]
