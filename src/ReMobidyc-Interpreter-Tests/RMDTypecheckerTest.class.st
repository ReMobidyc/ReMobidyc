Class {
	#name : #RMDTypecheckerTest,
	#superclass : #TestCase,
	#instVars : [
		'simulationModel'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #tests }
RMDTypecheckerTest >> testTypecheckSubject [

	self
		assert: (simulationModel typechecker
				 typecheck: 'world''s temperature + 30 [DegreeC]' asRMDExpression
				 subject: simulationModel worldDefinition)
		equals: (RMDType unit: (RMDUnit at: 'DegreeC')).
	self
		should: [ 
			simulationModel typechecker
				typecheck: 'world''s temperature + 10 [s]' asRMDExpression
				subject: simulationModel worldDefinition ]
		raise: RMDTypeError.
	self
		should: [ 
			simulationModel typechecker
				typecheck:
				'world''s temperature + the temp_offset' asRMDExpression
				subject: simulationModel worldDefinition ]
		raise: RMDUnresolvedPlaceholderError
]

{ #category : #tests }
RMDTypecheckerTest >> testWeakTypecheckSubject [

	| expr |
	expr := 'world''s temperature + the temp_offset' asRMDExpression.
	self
		should: [ 
			simulationModel typechecker
				typecheck: expr
				subject: simulationModel worldDefinition ]
		raise: RMDUnresolvedPlaceholderError.
	self
		assert: (simulationModel typechecker
				 weakTypecheck: expr
				 subject: simulationModel worldDefinition)
		equals: (RMDType unit: (RMDUnit at: 'DegreeC'))
]
