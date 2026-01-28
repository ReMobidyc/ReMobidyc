Class {
	#name : 'RMDPropertyDeclarationNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDPropertyDeclarationNodeTest >> testCopyReplace [
	| node replacement |
	node := parser attributeDeclaration end parse: 'blood_sugar [kcal]'.
	replacement := Dictionary new
		at: 'blood_sugar' put: 'energy';
		at: (parser type end parse: '[kcal]')
			put: (parser type end parse: '[J]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser attributeDeclaration end parse: 'energy [J]')
]
