Class {
	#name : #RMDNearestInterpolationTest,
	#superclass : #RMDDataInterpolationTest,
	#category : #'ReMobidyc-DataSource-Tests'
}

{ #category : #accessing }
RMDNearestInterpolationTest >> expected [

	^ #( #( 0.0 1.0 ) #( 2.0 1.0 ) #( 4.0 4.0 ) #( 5.0 4.0 ) #( 6.0 4.0 )
	     #( 7.0 5.0 ) #( 8 5.0 ) )
]
