Class {
	#name : #RMDUtilityDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDUtilityDefinitionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser utilityDefinition end parse: 'x = a + b'.
	replacement := Dictionary new
		at: 'x' put: 'y';
		at: (self expression: 'a') put: (self expression: 'my foo');
		at: (self expression: 'b') put: (self expression: '10 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser utilityDefinition end parse: 'y = my foo + 10 [kcal]')
]
