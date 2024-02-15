Class {
	#name : #RMDTableWithHBarPresenter,
	#superclass : #SpTablePresenter,
	#instVars : [
		'hasHorizontalScrollbar'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #specs }
RMDTableWithHBarPresenter class >> adapterName [

	^ #RMDMorphicTableWithHBarAdapter
]

{ #category : #api }
RMDTableWithHBarPresenter >> disableHorizontalScrollbar [

	self hasHorizontalScrollbar: false
]

{ #category : #api }
RMDTableWithHBarPresenter >> enableHorizontalScrollbar [

	self hasHorizontalScrollbar: true
]

{ #category : #api }
RMDTableWithHBarPresenter >> enableHorizontalScrollbar: aBoolean [

	self hasHorizontalScrollbar: aBoolean = true
]

{ #category : #testing }
RMDTableWithHBarPresenter >> hasHorizontalScrollbar [

	^ hasHorizontalScrollbar = true
]

{ #category : #accessing }
RMDTableWithHBarPresenter >> hasHorizontalScrollbar: aBoolean [

	hasHorizontalScrollbar := aBoolean = true
]

{ #category : #initialization }
RMDTableWithHBarPresenter >> initialize [

	super initialize.
	hasHorizontalScrollbar ifNil: [ hasHorizontalScrollbar := false ]
]
