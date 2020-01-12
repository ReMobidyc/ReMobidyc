Class {
	#name : #RMDUtilityVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDUtilityVariableNodeTest >> testEvalIn [
	interpreter context
		utilityAt: 'foo' put: 2.0;
		utilityAt: 'bar' put: 3.0.
	self
		assert: ((parser expression parse: 'foo') evalIn: interpreter)
		closeTo: 2.0.
	self
		assert: ((parser expression parse: 'bar') evalIn: interpreter)
		closeTo: 3.0.
	self
		should: [ (parser expression parse: 'nothing') evalIn: interpreter ]
		raise: KeyNotFound
]
