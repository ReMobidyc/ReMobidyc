Class {
	#name : #RMDCellColorMapRendererTest,
	#superclass : #RMDRendererTest,
	#category : #'ReMobidyc-Visualization-Tests'
}

{ #category : #accessing }
RMDCellColorMapRendererTest >> renderer [

	^ RMDPatchColorMapRenderer
		  expression: 'here''s val' asRMDExpression
		  color: Color white
		  value: '10' asRMDExpression
		  color: Color gray
		  value: '5' asRMDExpression
		  color: Color black
]
