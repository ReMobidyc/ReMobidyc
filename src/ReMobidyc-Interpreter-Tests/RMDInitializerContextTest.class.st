Class {
	#name : #RMDInitializerContextTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'context'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDInitializerContextTest >> setUp [
	context := RMDInitializerContext new.
	parser := RMDGrammar new
]

{ #category : #tests }
RMDInitializerContextTest >> testSpecies [
	| worldDef |
	worldDef := parser worldDefinition
		parse:
			'World with
	temperature [C]
	humidity [].'.
	context subject: 1 species: worldDef.
	self
		assert:
			(context
				getMemoryAddressFor: 'temperature'
				agent: nil
				ifAbsent: [ nil ])
		equals: (worldDef propertyOffsets at: 'temperature') + 1.
	self
		assert: (context getMemoryAddressFor: 'humidity' agent: nil ifAbsent: [ nil ])
		equals: (worldDef propertyOffsets at: 'humidity') + 1
]
