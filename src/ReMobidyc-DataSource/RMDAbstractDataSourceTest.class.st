Class {
	#name : #RMDAbstractDataSourceTest,
	#superclass : #TestCase,
	#instVars : [
		'dataSource'
	],
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #testing }
RMDAbstractDataSourceTest class >> isAbstract [

	^ self = RMDAbstractDataSourceTest
]

{ #category : #private }
RMDAbstractDataSourceTest >> dataSourceClass [

	^ self subclassResponsibility
]

{ #category : #running }
RMDAbstractDataSourceTest >> setUp [

	dataSource := self dataSourceClass new.
	dataSource dataFrame: ((DataFrame withRows:
				  #( #( 0.0 30.0 ) #( 1.0 30.1 ) #( 2.0 30.2 ) #( 4.0 30.4 )
				     #( 5.0 30.5 ) ))
			 columnNames: #( 'time[s]' 'temperature[℃]' );
			 yourself)
]

{ #category : #tests }
RMDAbstractDataSourceTest >> testIndexAtTime [

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
RMDAbstractDataSourceTest >> testUnitAt [

	self assert: (dataSource unitAt: 'time') equals: 's' asRMDUnit.
	self
		assert: (dataSource unitAt: 'temperature')
		equals: 'DegreeC' asRMDUnit
]
