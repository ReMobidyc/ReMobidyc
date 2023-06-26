Class {
	#name : #RMDLinearInterporatedTimeDataSourceTest,
	#superclass : #RMDAbstractDataSourceTest,
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #private }
RMDLinearInterporatedTimeDataSourceTest >> dataSourceClass [

	^ RMDLinearInterporatedTimeDataSource
]

{ #category : #tests }
RMDLinearInterporatedTimeDataSourceTest >> testAtTimeAt [

	self
		assert: (dataSource atTime: -1.0 at: 'temperature')
		closeTo: 30.0.
	self assert: (dataSource atTime: 0.0 at: 'temperature') closeTo: 30.0.
	self
		assert: (dataSource atTime: 0.5 at: 'temperature')
		closeTo: 30.05.
	self
		assert: (dataSource atTime: 0.99999 at: 'temperature')
		closeTo: 30.099999.
	self assert: (dataSource atTime: 1.0 at: 'temperature') closeTo: 30.1.
	self
		assert: (dataSource atTime: 1.5 at: 'temperature')
		closeTo: 30.15.
	self assert: (dataSource atTime: 2.0 at: 'temperature') closeTo: 30.2.
	self
		assert: (dataSource atTime: 2.5 at: 'temperature')
		closeTo: 30.25.
	self assert: (dataSource atTime: 3.0 at: 'temperature') closeTo: 30.3.
	self
		assert: (dataSource atTime: 3.5 at: 'temperature')
		closeTo: 30.35.
	self assert: (dataSource atTime: 4.0 at: 'temperature') closeTo: 30.4.
	self
		assert: (dataSource atTime: 4.5 at: 'temperature')
		closeTo: 30.45.
	self assert: (dataSource atTime: 5.0 at: 'temperature') closeTo: 30.5.
	self assert: (dataSource atTime: 5.5 at: 'temperature') closeTo: 30.5
]
