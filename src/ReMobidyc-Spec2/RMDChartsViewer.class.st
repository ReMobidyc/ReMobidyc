Class {
	#name : 'RMDChartsViewer',
	#superclass : 'RMDPresenter',
	#instVars : [
		'zoomButton',
		'fitButton',
		'panButton',
		'forms',
		'scale',
		'scrollableLayout'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'instance creation' }
RMDChartsViewer class >> withAll: aCollectionOfForm [

	^ self new
		  forms: aCollectionOfForm;
		  yourself
]

{ #category : 'layout' }
RMDChartsViewer >> defaultLayout [

	| innerLayout |
	innerLayout := SpBoxLayout newVertical.
	forms ifNotNil: [
		forms do: [ :form |
			innerLayout
				add: ((form magnifyBy: scale) asPresenter autoScale: false)
				expand: false ] ].
	^ SpBoxLayout newVertical
		  add: (scrollableLayout := (SpScrollableLayout with: innerLayout)
				                       hAlignCenter);
		  add: (SpBoxLayout newHorizontal
				   add: panButton expand: false;
				   add: fitButton expand: false;
				   add: zoomButton expand: false)
		  expand: false
]

{ #category : 'operations' }
RMDChartsViewer >> fit [

	forms ifNotEmpty: [
		self withAdapterDo: [ :a |
			a widgetDo: [ :w |
				self scale: (w height - 20 max: 10) / forms first extent y ] ] ]
]

{ #category : 'accessing' }
RMDChartsViewer >> forms [

	^ forms
]

{ #category : 'accessing' }
RMDChartsViewer >> forms: aCollectionOfForm [

	forms := aCollectionOfForm
]

{ #category : 'initialization' }
RMDChartsViewer >> initialize [

	super initialize.
	scale := 1
]

{ #category : 'initialization' }
RMDChartsViewer >> initializePresenters [

	scrollableLayout := SpScrollableLayout new.
	zoomButton := self newButton
		              label: '+';
		              action: [ self zoom ];
		              yourself.
	fitButton := self newButton
		             label: 'fit';
		             action: [ self fit ];
		             yourself.
	panButton := self newButton
		             label: '-';
		             action: [ self pan ];
		             yourself
]

{ #category : 'operations' }
RMDChartsViewer >> pan [

	self scale: self scale / 1.4
]

{ #category : 'accessing' }
RMDChartsViewer >> scale [

	^ scale
]

{ #category : 'accessing' }
RMDChartsViewer >> scale: aNumber [

	| hValue vValue |
	scale := aNumber.
	scrollableLayout ifNotNil: [
		scrollableLayout withAdapterDo: [ :a |
			a widgetDo: [ :w |
				hValue := w hScrollbarValue.
				vValue := w vScrollbarValue ] ] ].
	self layout: self defaultLayout.
	scrollableLayout ifNotNil: [
		scrollableLayout withAdapterDo: [ :a |
			a widgetDo: [ :w |
				hValue notNil ifTrue: [ w hScrollbarValue: hValue ].
				vValue notNil ifTrue: [ w vScrollbarValue: vValue ] ] ] ]
]

{ #category : 'operations' }
RMDChartsViewer >> zoom [

	self scale: self scale * 1.4
]
