Class {
	#name : #RMDFloorFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'floor'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDFloorFunctionTest >> setUp [ 
	floor := RMDFloorFunction new
]

{ #category : #tests }
RMDFloorFunctionTest >> testValue [
	self assert: (floor value: -1.6) closeTo: -2.0.
	self assert: (floor value: 1.6) closeTo: 1.0.
	self assert: (floor value: 3.2) closeTo: 3.0.
	self assert: (floor value: 10.0) closeTo: 10.0
]

{ #category : #tests }
RMDFloorFunctionTest >> testValueValue [

	self should: [ floor value: 1.0 value: 1.0 ] raise: Error
]

{ #category : #tests }
RMDFloorFunctionTest >> testValueValueValue [

	self should: [ floor value: 1.0 value: 1.0 value: 1.0 ] raise: Error
]

{ #category : #tests }
RMDFloorFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			floor
				value: 1.0
				value: 1.0
				value: 1.0
				value: 1.0 ]
		raise: Error
]
