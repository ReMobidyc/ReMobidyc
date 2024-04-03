Class {
	#name : #RMDIndividualsInRadiusDirectiveNode,
	#superclass : #RMDSimulationDirectiveNode,
	#instVars : [
		'animatName',
		'radius'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDIndividualsInRadiusDirectiveNode class >> animatName: aString radius: aRMDExpressionNode [

	^ self new
		  animatName: aString;
		  radius: aRMDExpressionNode;
		  yourself
]

{ #category : #testing }
RMDIndividualsInRadiusDirectiveNode class >> isAbstract [

	^ self = RMDIndividualsInRadiusDirectiveNode
]

{ #category : #accessing }
RMDIndividualsInRadiusDirectiveNode >> animatName [

	^ animatName
]

{ #category : #accessing }
RMDIndividualsInRadiusDirectiveNode >> animatName: aString [

	animatName := aString
]

{ #category : #converting }
RMDIndividualsInRadiusDirectiveNode >> asPresenter [

	^ RMDIndividualsInRadiusDirectivePresenter on: self
]

{ #category : #accessing }
RMDIndividualsInRadiusDirectiveNode >> directiveName [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDIndividualsInRadiusDirectiveNode >> locationName [

	^ 'radius'
]

{ #category : #utilities }
RMDIndividualsInRadiusDirectiveNode >> numberOfIndividualsIn: aNumber with: aRMDInterpreter [

	| interactionSpace count |
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter simulationModel north
		                    height: aRMDInterpreter simulationModel east
		                    range: aNumber.
	aRMDInterpreter simulationModel
		stagesOf: self animatName
		do: [ :stage |
			aRMDInterpreter individualsOf: stage do: [ :individual |
				aRMDInterpreter
					withObserverSubContextWithSubject: individual
					definition: stage
					do: [
						| x y |
						x := aRMDInterpreter my: 'x'.
						y := aRMDInterpreter my: 'y'.
						interactionSpace add: individual x: x y: y ] ] ].
	count := 0.
	interactionSpace
		animatsAroundX: (aRMDInterpreter my: 'x')
		y: (aRMDInterpreter my: 'y')
		do: [ :objectAnimat | count := count + 1 ].
	^ count
]

{ #category : #accessing }
RMDIndividualsInRadiusDirectiveNode >> radius [

	^ radius
]

{ #category : #accessing }
RMDIndividualsInRadiusDirectiveNode >> radius: aRMDExpressionNode [

	radius := aRMDExpressionNode
]
