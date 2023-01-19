Class {
	#name : #RMDInitializerContext,
	#superclass : #RMDExecutionContextWithRandomGenerator,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDInitializerContext >> world: anInteger definition: aRMDWorldDefinition [
	| dict |
	dict := Dictionary new.
	aRMDWorldDefinition
		attributeOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	attributeDict at: 'world' put: dict
]

{ #category : #accessing }
RMDInitializerContext >> worldAttributeDict: aDictionary [

	attributeDict at: 'world' put: aDictionary
]
