Class {
	#name : #RMDNearestTimeDataSourceTest,
	#superclass : #RMDAbstractDataSourceTest,
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #private }
RMDNearestTimeDataSourceTest >> dataSourceClass [

	^ RMDNearestTimeDataSource
]

{ #category : #tests }
RMDNearestTimeDataSourceTest >> testAtTimeAt [

	self
		assert: (dataSource atTime: -1.0 at: 'temperature')
		closeTo: 30.0.
	self assert: (dataSource atTime: 0.0 at: 'temperature') closeTo: 30.0.
	self
		assert: (dataSource atTime: 0.45 at: 'temperature')
		closeTo: 30.0.
	self
		assert: (dataSource atTime: 0.99999 at: 'temperature')
		closeTo: 30.1.
	self assert: (dataSource atTime: 1.0 at: 'temperature') closeTo: 30.1.
	self
		assert: (dataSource atTime: 1.45 at: 'temperature')
		closeTo: 30.1.
	self
		assert: (dataSource atTime: 1.55 at: 'temperature')
		closeTo: 30.2.
	self assert: (dataSource atTime: 2.0 at: 'temperature') closeTo: 30.2.
	self
		assert: (dataSource atTime: 2.45 at: 'temperature')
		closeTo: 30.2.
	self assert: (dataSource atTime: 3.5 at: 'temperature') closeTo: 30.4.
	self assert: (dataSource atTime: 4.0 at: 'temperature') closeTo: 30.4.
	self
		assert: (dataSource atTime: 4.45 at: 'temperature')
		closeTo: 30.4.
	self assert: (dataSource atTime: 5.0 at: 'temperature') closeTo: 30.5.
	self assert: (dataSource atTime: 5.5 at: 'temperature') closeTo: 30.5
]
