Class {
	#name : #RMDTypecheckerTest,
	#superclass : #TestCase,
	#instVars : [
		'simulationModel'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDTypecheckerTest >> setUp [

	super setUp.
	simulationModel := RMDSimulationModel new.
	simulationModel load:
		(String cr join: #( 'World with' '	temperature [DegreeC].' ))
			asRMDWorldDefinition
]

{ #category : #tests }
RMDTypecheckerTest >> testTypecheck [

	self
		assert: (simulationModel typechecker typecheck:
				 'world''s temperature + 30 [DegreeC]' asRMDExpression)
		equals: (RMDType unit: (RMDUnit at: 'DegreeC')).
	self
		should: [ 
			simulationModel typechecker typecheck:
				'world''s temperature + 10 [s]' asRMDExpression ]
		raise: RMDTypeError.
	self
		should: [ 
			simulationModel typechecker typecheck:
				'world''s temperature + the temp_offset' asRMDExpression ]
		raise: RMDUnresolvedPlaceholderError
]

{ #category : #tests }
RMDTypecheckerTest >> testWeakTypecheck [

	| expr |
	expr := 'world''s temperature + the temp_offset' asRMDExpression.
	self
		should: [ simulationModel typechecker typecheck: expr ]
		raise: RMDUnresolvedPlaceholderError.
	self
		assert: (simulationModel typechecker weakTypecheck: expr)
		equals: (RMDType unit: (RMDUnit at: 'DegreeC'))
]
