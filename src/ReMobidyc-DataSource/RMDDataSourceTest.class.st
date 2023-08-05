Class {
	#name : #RMDDataSourceTest,
	#superclass : #TestCase,
	#instVars : [
		'dataSource'
	],
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #running }
RMDDataSourceTest >> setUp [

	dataSource := RMDDataSource dataFrame: ((DataFrame withRows:
				                #( #( 0.0 30.0 30.0 30.0 ) #( 1.0 30.1 30.1 30.1 )
				                   #( 2.0 30.2 30.2 30.2 ) #( 4.0 30.4 30.4 30.4 )
				                   #( 5.0 30.5 30.5 30.5 ) ))
			               columnNames:
				               #( 'time[s]' 't1[℃]' 't2[℃] nearest'
				                  't3[℃] linear' );
			               yourself)
]

{ #category : #'tests-interpolation' }
RMDDataSourceTest >> testAtTime [

	self assert: ((dataSource atTime: -1.0) at: 't1') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.0) at: 't1') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.5) at: 't1') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.99999) at: 't1') closeTo: 30.0.
	self assert: ((dataSource atTime: 1.0) at: 't1') closeTo: 30.1.
	self assert: ((dataSource atTime: 1.5) at: 't1') closeTo: 30.1.
	self assert: ((dataSource atTime: 2.0) at: 't1') closeTo: 30.2.
	self assert: ((dataSource atTime: 2.5) at: 't1') closeTo: 30.2.
	self assert: ((dataSource atTime: 3.0) at: 't1') closeTo: 30.2.
	self assert: ((dataSource atTime: 3.5) at: 't1') closeTo: 30.2.
	self assert: ((dataSource atTime: 4.0) at: 't1') closeTo: 30.4.
	self assert: ((dataSource atTime: 4.5) at: 't1') closeTo: 30.4.
	self assert: ((dataSource atTime: 5.0) at: 't1') closeTo: 30.5.
	self assert: ((dataSource atTime: 5.5) at: 't1') closeTo: 30.5.
	self assert: ((dataSource atTime: -1.0) at: 't2') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.0) at: 't2') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.45) at: 't2') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.99999) at: 't2') closeTo: 30.1.
	self assert: ((dataSource atTime: 1.0) at: 't2') closeTo: 30.1.
	self assert: ((dataSource atTime: 1.45) at: 't2') closeTo: 30.1.
	self assert: ((dataSource atTime: 1.55) at: 't2') closeTo: 30.2.
	self assert: ((dataSource atTime: 2.0) at: 't2') closeTo: 30.2.
	self assert: ((dataSource atTime: 2.45) at: 't2') closeTo: 30.2.
	self assert: ((dataSource atTime: 3.5) at: 't2') closeTo: 30.4.
	self assert: ((dataSource atTime: 4.0) at: 't2') closeTo: 30.4.
	self assert: ((dataSource atTime: 4.45) at: 't2') closeTo: 30.4.
	self assert: ((dataSource atTime: 5.0) at: 't2') closeTo: 30.5.
	self assert: ((dataSource atTime: 5.5) at: 't2') closeTo: 30.5.
	self assert: ((dataSource atTime: -1.0) at: 't3') closeTo: 29.9.
	self assert: ((dataSource atTime: 0.0) at: 't3') closeTo: 30.0.
	self assert: ((dataSource atTime: 0.5) at: 't3') closeTo: 30.05.
	self
		assert: ((dataSource atTime: 0.99999) at: 't3')
		closeTo: 30.099999.
	self assert: ((dataSource atTime: 1.0) at: 't3') closeTo: 30.1.
	self assert: ((dataSource atTime: 1.5) at: 't3') closeTo: 30.15.
	self assert: ((dataSource atTime: 2.0) at: 't3') closeTo: 30.2.
	self assert: ((dataSource atTime: 2.5) at: 't3') closeTo: 30.25.
	self assert: ((dataSource atTime: 3.0) at: 't3') closeTo: 30.3.
	self assert: ((dataSource atTime: 3.5) at: 't3') closeTo: 30.35.
	self assert: ((dataSource atTime: 4.0) at: 't3') closeTo: 30.4.
	self assert: ((dataSource atTime: 4.5) at: 't3') closeTo: 30.45.
	self assert: ((dataSource atTime: 5.0) at: 't3') closeTo: 30.5.
	self assert: ((dataSource atTime: 5.5) at: 't3') closeTo: 30.55
]

{ #category : #'tests-interpolation' }
RMDDataSourceTest >> testAtTimeAt [

	self assert: (dataSource atTime: -1.0 at: 't1') closeTo: 30.0.
	self assert: (dataSource atTime: 0.0 at: 't1') closeTo: 30.0.
	self assert: (dataSource atTime: 0.5 at: 't1') closeTo: 30.0.
	self assert: (dataSource atTime: 0.99999 at: 't1') closeTo: 30.0.
	self assert: (dataSource atTime: 1.0 at: 't1') closeTo: 30.1.
	self assert: (dataSource atTime: 1.5 at: 't1') closeTo: 30.1.
	self assert: (dataSource atTime: 2.0 at: 't1') closeTo: 30.2.
	self assert: (dataSource atTime: 2.5 at: 't1') closeTo: 30.2.
	self assert: (dataSource atTime: 3.0 at: 't1') closeTo: 30.2.
	self assert: (dataSource atTime: 3.5 at: 't1') closeTo: 30.2.
	self assert: (dataSource atTime: 4.0 at: 't1') closeTo: 30.4.
	self assert: (dataSource atTime: 4.5 at: 't1') closeTo: 30.4.
	self assert: (dataSource atTime: 5.0 at: 't1') closeTo: 30.5.
	self assert: (dataSource atTime: 5.5 at: 't1') closeTo: 30.5.
	self assert: (dataSource atTime: -1.0 at: 't2') closeTo: 30.0.
	self assert: (dataSource atTime: 0.0 at: 't2') closeTo: 30.0.
	self assert: (dataSource atTime: 0.45 at: 't2') closeTo: 30.0.
	self assert: (dataSource atTime: 0.99999 at: 't2') closeTo: 30.1.
	self assert: (dataSource atTime: 1.0 at: 't2') closeTo: 30.1.
	self assert: (dataSource atTime: 1.45 at: 't2') closeTo: 30.1.
	self assert: (dataSource atTime: 1.55 at: 't2') closeTo: 30.2.
	self assert: (dataSource atTime: 2.0 at: 't2') closeTo: 30.2.
	self assert: (dataSource atTime: 2.45 at: 't2') closeTo: 30.2.
	self assert: (dataSource atTime: 3.5 at: 't2') closeTo: 30.4.
	self assert: (dataSource atTime: 4.0 at: 't2') closeTo: 30.4.
	self assert: (dataSource atTime: 4.45 at: 't2') closeTo: 30.4.
	self assert: (dataSource atTime: 5.0 at: 't2') closeTo: 30.5.
	self assert: (dataSource atTime: 5.5 at: 't2') closeTo: 30.5.
	self assert: (dataSource atTime: -1.0 at: 't3') closeTo: 29.9.
	self assert: (dataSource atTime: 0.0 at: 't3') closeTo: 30.0.
	self assert: (dataSource atTime: 0.5 at: 't3') closeTo: 30.05.
	self assert: (dataSource atTime: 0.99999 at: 't3') closeTo: 30.099999.
	self assert: (dataSource atTime: 1.0 at: 't3') closeTo: 30.1.
	self assert: (dataSource atTime: 1.5 at: 't3') closeTo: 30.15.
	self assert: (dataSource atTime: 2.0 at: 't3') closeTo: 30.2.
	self assert: (dataSource atTime: 2.5 at: 't3') closeTo: 30.25.
	self assert: (dataSource atTime: 3.0 at: 't3') closeTo: 30.3.
	self assert: (dataSource atTime: 3.5 at: 't3') closeTo: 30.35.
	self assert: (dataSource atTime: 4.0 at: 't3') closeTo: 30.4.
	self assert: (dataSource atTime: 4.5 at: 't3') closeTo: 30.45.
	self assert: (dataSource atTime: 5.0 at: 't3') closeTo: 30.5.
	self assert: (dataSource atTime: 5.5 at: 't3') closeTo: 30.55
]

{ #category : #'tests-time' }
RMDDataSourceTest >> testIndexAtTime [

	self assert: (dataSource indexAtTime: -1.0) equals: 1.
	self assert: (dataSource indexAtTime: 0.0) equals: 1.
	self assert: (dataSource indexAtTime: 0.5) equals: 1.
	self assert: (dataSource indexAtTime: 0.99999) equals: 1.
	self assert: (dataSource indexAtTime: 1.0) equals: 2.
	self assert: (dataSource indexAtTime: 1.000001) equals: 2.
	self assert: (dataSource indexAtTime: 2.0) equals: 3.
	self assert: (dataSource indexAtTime: 3.0) equals: 3.
	self assert: (dataSource indexAtTime: 4.0) equals: 4.
	self assert: (dataSource indexAtTime: 5.0) equals: 4.
	self assert: (dataSource indexAtTime: 6.0) equals: 4
]

{ #category : #tests }
RMDDataSourceTest >> testUnitAt [

	self assert: (dataSource unitAt: 'time') equals: 's' asRMDUnit.
	self assert: (dataSource unitAt: 't1') equals: 'DegreeC' asRMDUnit.
	self assert: (dataSource unitAt: 't2') equals: 'DegreeC' asRMDUnit.
	self assert: (dataSource unitAt: 't3') equals: 'DegreeC' asRMDUnit
]
