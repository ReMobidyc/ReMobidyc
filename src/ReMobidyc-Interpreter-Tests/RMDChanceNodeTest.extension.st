Extension { #name : #RMDChanceNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDChanceNodeTest >> testEvalIn [

	self
		assert: ((parser condition parse: '0 chance') evalIn: interpreter)
		equals: false.
	self
		assert:
		((parser condition parse: '100 [%] chance') evalIn: interpreter)
		equals: true
]

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDChanceNodeTest >> testTypecheckIn [

	self
		assert: ((parser condition parse: '0 chance') typecheckIn:
				 interpreter simulationModel typechecker)
		equals: nil.
	self
		should: [ 
			(parser condition parse: '100 [m] chance') typecheckIn:
				interpreter simulationModel typechecker ]
		raise: RMDTypeError
]
