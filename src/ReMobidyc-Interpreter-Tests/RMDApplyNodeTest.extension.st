Extension { #name : #RMDApplyNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDApplyNodeTest >> testEvalIn [

	interpreter addLibrary: { 
			('plus' -> [ :x :y | x + y ]).
			('abs' -> [ :x | x abs ]) } asDictionary.
	self
		assert:
		((parser expression parse: 'plus(2, 3)') evalIn: interpreter)
		closeTo: 5.0.
	self
		assert: ((parser expression parse: 'abs(-2)') evalIn: interpreter)
		closeTo: 2.0.
	self
		should: [ (parser expression parse: 'foo(-2)') evalIn: interpreter ]
		raise: RMDUndefinedFunctionError
]
