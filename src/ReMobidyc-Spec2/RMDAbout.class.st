Class {
	#name : 'RMDAbout',
	#superclass : 'RMDPresenter',
	#instVars : [
		'logoImage',
		'releaseLabel'
	],
	#category : 'ReMobidyc-Spec2-Utilities',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Utilities'
}

{ #category : 'layout' }
RMDAbout class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #logoImage;
		  yourself
]

{ #category : 'instance creation' }
RMDAbout class >> open [

	<script>
	self new open
]

{ #category : 'menus' }
RMDAbout class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycAbout)
		parent: 'ReMobidyc';
		order: 999;
		label: 'About...';
		action: [ RMDAbout open ];
		help: 'Open an about window.'
]

{ #category : 'accessing' }
RMDAbout >> codename [
	^ BaselineOfReMobidyc codename
]

{ #category : 'initialization' }
RMDAbout >> initialExtent [

	^ (logoImage ifNotNil: #image)
		  ifNotNil: [ :form | form extent + (4 @ 4) ]
		  ifNil: [ 700 @ 800 ]
]

{ #category : 'initialization' }
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

{ #category : 'accessing' }
RMDAbout >> logo [

	^ self logoPath isFile ifTrue: [
		  | logo font |
		  logo := PNGReadWriter formFromFileNamed: self logoPath.
		  font := LogicalFont
			          familyName: 'Bitmap DejaVu Sans'
			          pointSize: 24
			          stretchValue: 5
			          weightValue: 400
			          slantValue: 10.
		  logo getCanvas
			  drawString: self codename
			  at:
			  logo extent - ((font widthOfString: self codename) @ font height)
			  font: font
			  color: Color darkGray.
		  logo ]
]

{ #category : 'accessing' }
RMDAbout >> logoPath [

	^ FileLocator localDirectory / 'ReMobidyc' / 'logos' / 'default.png'
]

{ #category : 'accessing' }
RMDAbout >> releaseName [
	^ 'reːmobidyc ', self codename
]

{ #category : 'accessing' }
RMDAbout >> windowTitle [

	^ self releaseName
]
