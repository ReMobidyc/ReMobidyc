Class {
	#name : #RMDScrollPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'presenter'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #specs }
RMDScrollPresenter class >> defaultSpec [

	^ SpScrollableLayout with: #presenter
]

{ #category : #'instance creation' }
RMDScrollPresenter class >> with: aPresenter [
	^ self new
		presenter: aPresenter;
		yourself
]

{ #category : #initialization }
RMDScrollPresenter >> initializePresenters [
	super initializePresenters
]

{ #category : #accessing }
RMDScrollPresenter >> presenter [
	^ presenter
]

{ #category : #accessing }
RMDScrollPresenter >> presenter: aPresenter [
	presenter := aPresenter
]
