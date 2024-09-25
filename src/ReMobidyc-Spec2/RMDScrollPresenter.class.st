Class {
	#name : 'RMDScrollPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'presenter'
	],
	#category : 'ReMobidyc-Spec2-Widgets',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Widgets'
}

{ #category : 'layout' }
RMDScrollPresenter class >> defaultLayout [

	^ SpScrollableLayout with: #presenter
]

{ #category : 'instance creation' }
RMDScrollPresenter class >> with: aPresenter [
	^ self new
		presenter: aPresenter;
		yourself
]

{ #category : 'initialization' }
RMDScrollPresenter >> initializePresenters [
	super initializePresenters
]

{ #category : 'accessing' }
RMDScrollPresenter >> presenter [
	^ presenter
]

{ #category : 'accessing' }
RMDScrollPresenter >> presenter: aPresenter [
	presenter := aPresenter
]
