Class {
	#name : #RMDSimulationPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'resetButton',
		'runButton',
		'interpreter',
		'go',
		'process'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSimulationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #resetButton height: self buttonHeight;
		add: #runButton height: self buttonHeight;
		yourself
]
