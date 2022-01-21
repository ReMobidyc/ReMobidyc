Class {
	#name : #RMDTaskDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDTaskDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser taskDefinition end parse:
		        'A chase nearest B within 1 [km] namely move
when distance b > 500[m]
where
	the heading -> direction b
	the speed -> 30 [km/h].'.
	copy := parser taskDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser taskDefinition end parse:
		        'A chase@model B within 1 [km]
when distance b > 500[m]
where
	the heading -> direction b
	the speed -> 30 [km/h].'.
	copy := parser taskDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser taskDefinition end parse:
		        'A chase nearest B within 10 [km] namely move_toward.'.
	copy := parser taskDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser taskDefinition end parse:
		        'A starve@model.'.
	copy := parser taskDefinition end parse: node printString.
	self assert: copy equals: node
]
