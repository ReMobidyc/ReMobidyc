Class {
	#name : #RMDCellColorBrightnessRendererTest,
	#superclass : #RMDRendererTest,
	#category : #'ReMobidyc-Visualization-Tests'
}

{ #category : #accessing }
RMDCellColorBrightnessRendererTest >> renderer [

	^ RMDCellColorBrightnessRenderer
		  color: Color green
		  brightness: 'my grass' asRMDExpression
		  between: '0 [kcal]' asRMDExpression
		  and: '10000 [kcal]' asRMDExpression
]
