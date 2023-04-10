Class {
	#name : #RMDAbout,
	#superclass : #RMDPresenter,
	#instVars : [
		'logoImage',
		'releaseLabel'
	],
	#category : #'ReMobidyc-Spec2-Utilities'
}

{ #category : #layout }
RMDAbout class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #logoImage;
		  yourself
]

{ #category : #menus }
RMDAbout class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycAbout)
		parent: 'ReMobidyc';
		order: 999;
		label: 'About...';
		action: [ RMDAbout new open ];
		help: 'Open an about window.'
]

{ #category : #accessing }
RMDAbout >> codename [
	^ 'Thonon'
]

{ #category : #initialization }
RMDAbout >> initialExtent [

	^ 600 @ 600
]

{ #category : #initialization }
RMDAbout >> initializePresenters [

	super initializePresenters.
	logoImage := self newImage
		             autoScale: true;
		             image: self logo;
		             whenBuiltDo: [ 
			             logoImage withAdapterDo: [ :a | 
					             a widgetDo: [ :w | w color: (Color gray: 0.95) ] ] ]
				             yourself
]

{ #category : #accessing }
RMDAbout >> logo [

	^ self logoPath isFile ifTrue: [ 
		  PNGReadWriter formFromFileNamed: self logoPath ]
]

{ #category : #accessing }
RMDAbout >> logoPath [

	^ FileLocator localDirectory / 'ReMobidyc' / 'logos' / 'default.png'
]

{ #category : #accessing }
RMDAbout >> releaseName [
	^ 'reːmobidyc ', self codename
]

{ #category : #accessing }
RMDAbout >> title [

	^ self releaseName
]
