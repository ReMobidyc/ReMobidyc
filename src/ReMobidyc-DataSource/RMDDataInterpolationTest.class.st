Class {
	#name : #RMDDataInterpolationTest,
	#superclass : #TestCase,
	#instVars : [
		'dataFrame'
	],
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #testing }
RMDDataInterpolationTest class >> isAbstract [

	^ self = RMDDataInterpolationTest
]

{ #category : #accessing }
RMDDataInterpolationTest >> expected [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDDataInterpolationTest >> interpolation [

	^ (Smalltalk at:
		   (self class name copyFrom: 1 to: self class name size - 4)
			   asSymbol) current
]

{ #category : #running }
RMDDataInterpolationTest >> setUp [

	dataFrame := DataFrame withRows:
		             #( #( 0.0 nil ) #( 2.0 1.0 ) #( 4.0 nil ) #( 5.0 4.0 )
		                #( 6.0 nil ) #( 7.0 5.0 ) #( 8 nil ) )
]

{ #category : #tests }
RMDDataInterpolationTest >> testInterpolateDataFrameColumnAt [

	self interpolation interpolateDataFrame: dataFrame columnAt: 2.
	self assert: dataFrame asArray equals: self expected asArray
]
