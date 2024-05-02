Class {
	#name : 'RMDScatterPlot',
	#superclass : 'RSScatterPlot',
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'rendering' }
RMDScatterPlot >> renderIn: canvas [

	| newPoint |
	self checkAssertion.
	ellipses := (1 to: xValues size)
		            collect: [ :notUsed | self shape copy ]
		            as: RSGroup.
	xValues doWithIndex: [ :xt :i |
		| yt et |
		et := ellipses at: i.
		yt := yValues at: i.
		newPoint := self scalePoint: xt @ yt.
		(self isPointWellDefined: newPoint) ifTrue: [
			et model: xt @ yt.
			et translateTo: newPoint.
			canvas add: et ] ]
]
