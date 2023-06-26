Class {
	#name : #RMDLatestTimeDataSourceTest,
	#superclass : #RMDAbstractDataSourceTest,
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #private }
RMDLatestTimeDataSourceTest >> dataSourceClass [

	^ RMDLatestTimeDataSource
]

{ #category : #tests }
RMDLatestTimeDataSourceTest >> testAtTimeAt [

	self assert: (dataSource atTime: -1.0 at: 'temperature') equals: 30.0.
	self assert: (dataSource atTime: 0.0 at: 'temperature') equals: 30.0.
	self assert: (dataSource atTime: 0.5 at: 'temperature') equals: 30.0.
	self
		assert: (dataSource atTime: 0.99999 at: 'temperature')
		equals: 30.0.
	self assert: (dataSource atTime: 1.0 at: 'temperature') equals: 30.1.
	self assert: (dataSource atTime: 1.5 at: 'temperature') equals: 30.1.
	self assert: (dataSource atTime: 2.0 at: 'temperature') equals: 30.2.
	self assert: (dataSource atTime: 2.5 at: 'temperature') equals: 30.2.
	self assert: (dataSource atTime: 3.0 at: 'temperature') equals: 30.2.
	self assert: (dataSource atTime: 3.5 at: 'temperature') equals: 30.2.
	self assert: (dataSource atTime: 4.0 at: 'temperature') equals: 30.4.
	self assert: (dataSource atTime: 4.5 at: 'temperature') equals: 30.4.
	self assert: (dataSource atTime: 5.0 at: 'temperature') equals: 30.5.
	self assert: (dataSource atTime: 5.5 at: 'temperature') equals: 30.5
]
