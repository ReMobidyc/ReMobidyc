Class {
	#name : #RMDCellColorAlphaRendererTest,
	#superclass : #RMDRendererTest,
	#category : #'ReMobidyc-Visualization-Tests'
}

{ #category : #accessing }
RMDCellColorAlphaRendererTest >> renderer [

	^ RMDPatchColorAlphaRenderer
		  color: Color green
		  alpha: 'my grass' asRMDExpression
		  between: '0 [kcal]' asRMDExpression
		  and: '10000 [kcal]' asRMDExpression
]
