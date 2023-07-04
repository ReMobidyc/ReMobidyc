Class {
	#name : #RMDUnitTest,
	#superclass : #TestCase,
	#instVars : [
		'kg',
		'kelvin',
		'hour',
		'acre',
		'celsius',
		'second',
		'meter',
		'ton',
		'km',
		'mile',
		'fahrenheit'
	],
	#category : #'ReMobidyc-Units-Tests'
}

{ #category : #running }
RMDUnitTest >> setUp [

	meter := RMDUnitSymbol at: 'm'.
	km := RMDUnit at: 'km'.
	mile := RMDUnit at: 'mi'.
	ton := RMDUnitSymbol at: 't'.
	kg := RMDUnitSymbol at: 'kg'.
	hour := RMDUnitSymbol at: 'h'.
	second := RMDUnitSymbol at: 's'.
	acre := RMDUnitSymbol at: 'ac'.
	kelvin := RMDUnitSymbol at: 'K'.
	celsius := RMDUnitSymbol at: 'DegreeC'.
	fahrenheit := RMDUnitSymbol at: 'DegreeF'
]

{ #category : #tests }
RMDUnitTest >> testFromSI [

	self assert: (meter fromSI: 3.14) closeTo: 3.14.
	self assert: (kg fromSI: 83.5) closeTo: 83.5.
	self assert: (second fromSI: 0.3) closeTo: 0.3.
	self assert: (kelvin fromSI: 300.0) closeTo: 300.0.
	self assert: (ton fromSI: 550000) closeTo: 550.0.
	self assert: (hour fromSI: 1800.0) closeTo: 0.5.
	self assert: (celsius fromSI: 300.15) closeTo: 300.15.
	self assert: (acre fromSI: 121406) closeTo: 30.
	self assert: (meter / hour fromSI: 8.3333333333333) closeTo: 30000.0
]

{ #category : #tests }
RMDUnitTest >> testIsLength [

	self assert: meter isLength.
	self assert: km isLength.
	self deny: kg isLength.
	self deny: (meter / hour) isLength
]

{ #category : #tests }
RMDUnitTest >> testIsTemperature [

	self assert: kelvin isTemperature.
	self assert: celsius isTemperature.
	self assert: fahrenheit isTemperature.
	self deny: meter isTemperature.
	self deny: kg isTemperature.
	self deny: (meter / hour) isTemperature
]

{ #category : #tests }
RMDUnitTest >> testSiUnit [
	self assert: meter siUnit equals: meter.
	self assert: kg siUnit equals: kg.
	self assert: second siUnit equals: second.
	self assert: kelvin siUnit equals: kelvin.
	self assert: ton siUnit equals: kg.
	self assert: hour siUnit equals: second.
	self assert: acre siUnit equals: meter * meter.
	self assert: (meter * ton / hour) siUnit equals: meter * kg / second.
	self assert: (acre * kelvin) siUnit equals: meter * meter * kelvin
]

{ #category : #tests }
RMDUnitTest >> testToSI [

	self assert: (meter toSI: 3.14) closeTo: 3.14.
	self assert: (kg toSI: 83.5) closeTo: 83.5.
	self assert: (second toSI: 0.3) closeTo: 0.3.
	self assert: (kelvin toSI: 300.0) closeTo: 300.0.
	self assert: (ton toSI: 550) closeTo: 550000.0.
	self assert: (hour toSI: 0.5) closeTo: 1800.0.
	self assert: (acre toSI: 30) closeTo: 121405.692672.
	self assert: (meter / hour toSI: 30000.0) closeTo: 8.3333333333333
]
