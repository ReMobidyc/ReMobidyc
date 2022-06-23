Class {
	#name : #RMDAPNGWriter,
	#superclass : #ImageReadWriter,
	#instVars : [
		'defaultImage',
		'numFrames',
		'numPlays',
		'sequenceNumber',
		'disposeOp',
		'blendOp',
		'acTL'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDAPNGWriter class >> examplePNG [

	<script: 'RMDAPNGWriter examplePNG'>
	| form |
	form := Form extent: 500 @ 500 depth: 32.
	form getCanvas fillColor: Color red.
	FileLocator desktop / 'example.png' binaryWriteStreamDo: [ :stream | 
		| writer |
		writer := (RMDAPNGWriter on: stream)
			          defaultImage: form;
			          yourself.
		1 to: 200 by: 10 do: [ :r | 
			form getCanvas
				fillColor: Color black;
				fillOval: ((250 - r) asPoint corner: (250 + r) asPoint)
				color: Color white.
			writer nextPutImage: form ].
		writer close ]
]

{ #category : #examples }
RMDAPNGWriter class >> examplePNG2 [

	<script: 'RMDAPNGWriter examplePNG2'>
	| form |
	form := Form extent: 500 @ 500 depth: 32.
	form getCanvas fillColor: Color red.
	FileLocator desktop / 'example.png' binaryWriteStreamDo: [ :stream | 
		| writer |
		writer := RMDAPNGWriter on: stream.

		1 to: 200 by: 10 do: [ :r | 
			form getCanvas
				fillColor: Color black;
				fillOval: ((250 - r) asPoint corner: (250 + r) asPoint)
				color: Color white.
			writer nextPutImage: form ].
		writer close ]
]

{ #category : #'stream access' }
RMDAPNGWriter >> close [

	self write_acTL.
	self write_IEND.
	^ super close
]

{ #category : #accessing }
RMDAPNGWriter >> defaultImage: aForm [

	defaultImage := aForm.
	self
		nextPutAll: self fileSignature;
		write_IHDR: aForm;
		write_acTL;
		write_IDAT: aForm
]

{ #category : #private }
RMDAPNGWriter >> fileSignature [

	^ #[ 16r89 16r50 16r4E 16r47 16r0D 16r0A 16r1A 16r0A ]
]

{ #category : #private }
RMDAPNGWriter >> frameDataFrom: aForm writeInto: aStream [

	| zStream width height scanline hack hackBlt cm |
	zStream := ZLibWriteStream on: aStream.

	width := aForm width.
	height := aForm height.
	scanline := ByteArray new: width * 4.
	hack := Form extent: width @ 1 depth: 32 bits: scanline.
	hackBlt := BitBlt toForm: hack.
	hackBlt sourceForm: aForm.
	hackBlt combinationRule: Form over.
	hackBlt destOrigin: 0 @ 0.
	hackBlt
		width: width;
		height: 1.
	cm := EndianDetector isBigEndian
		      ifTrue: [ 
			      ColorMap
				      shifts: #( 8 8 8 -24 )
				      masks: #( 16rFF0000 16rFF00 16rFF 16rFF000000 ) ]
		      ifFalse: [ 
			      ColorMap
				      shifts: #( -16 0 16 0 )
				      masks: #( 16rFF0000 16rFF00 16rFF 16rFF000000 ) ].
	hackBlt colorMap: cm.
	0 to: height - 1 do: [ :i | 
		hackBlt
			sourceOrigin: 0 @ i;
			copyBits.
		zStream nextPut: 0. "filterType"
		zStream nextPutAll: scanline ].
	zStream close
]

{ #category : #initialize }
RMDAPNGWriter >> initialize [

	super initialize.
	defaultImage := nil.
	numFrames := 1.
	numPlays := 0.
	sequenceNumber := 0.
	disposeOp := 0.
	blendOp := 0.
	acTL := nil.
]

{ #category : #accessing }
RMDAPNGWriter >> nextImage [

	^ self shouldNotImplement
]

{ #category : #accessing }
RMDAPNGWriter >> nextPutImage: aForm [
	self nextPutImage: aForm delay: 0
]

{ #category : #accessing }
RMDAPNGWriter >> nextPutImage: aForm delay: anInteger [

	acTL
		ifNil: [ 
			defaultImage := aForm.
			self
				nextPutAll: self fileSignature;
				write_IHDR: aForm;
				write_acTL;
				write_fcTL: aForm offset: 0 @ 0 delay: anInteger;
				write_IDAT: aForm ]
		ifNotNil: [ 
			self
				write_fcTL: aForm offset: 0 @ 0 delay: anInteger;
				write_fdAT: aForm ]
]

{ #category : #accessing }
RMDAPNGWriter >> numFrames [

	^ numFrames
]

{ #category : #accessing }
RMDAPNGWriter >> numFrames: anInteger [

	numFrames := anInteger
]

{ #category : #accessing }
RMDAPNGWriter >> numPlays [

	^ numPlays
]

{ #category : #accessing }
RMDAPNGWriter >> numPlays: anInteger [

	numPlays := anInteger
]

{ #category : #accessing }
RMDAPNGWriter >> setBlendOpOver [
	blendOp := 1
]

{ #category : #accessing }
RMDAPNGWriter >> setBlendOpSource [
	blendOp := 0
]

{ #category : #accessing }
RMDAPNGWriter >> setDisposeOpBackground [
	disposeOp := 1
]

{ #category : #accessing }
RMDAPNGWriter >> setDisposeOpNone [
	disposeOp := 0
]

{ #category : #accessing }
RMDAPNGWriter >> setDisposeOpPrevious [
	disposeOp := 2
]

{ #category : #private }
RMDAPNGWriter >> writeChunk: aString streamContents: aBlock [

	| chunk crc |
	chunk := ByteArray streamContents: [ :byteStream | 
		         byteStream nextPutAll: aString asByteArray.
		         aBlock value: byteStream ].

	crc := (CRC
		        update: 4294967295
		        from: 1
		        to: chunk size
		        in: chunk) bitXor: 4294967295.
	self
		nextLongPut: chunk size - aString size;
		nextPutAll: chunk;
		nextLongPut: crc
]

{ #category : #chunks }
RMDAPNGWriter >> write_IDAT: aForm [

	self
		writeChunk: 'IDAT'
		streamContents: [ :byteStream | 
		self frameDataFrom: aForm writeInto: byteStream ]
]

{ #category : #chunks }
RMDAPNGWriter >> write_IEND [

	self writeChunk: 'IEND' streamContents: [ :byteStream |  ]
]

{ #category : #chunks }
RMDAPNGWriter >> write_IHDR: aForm [

	self writeChunk: 'IHDR' streamContents: [ :byteStream | 
		byteStream
			nextInt32Put: aForm width;
			nextInt32Put: aForm height;
			nextPut: 8;
			nextPut: 6;
			nextPut: 0;
			nextPut: 0;
			nextPut: 0 ]
]

{ #category : #chunks }
RMDAPNGWriter >> write_acTL [

	| pos |
	pos := nil.
	acTL ifNil: [ acTL := stream position ] ifNotNil: [ 
		pos := stream position.
		stream position: acTL ].
	self writeChunk: 'acTL' streamContents: [ :byteStream | 
		byteStream
			nextInt32Put: numFrames;
			nextInt32Put: numPlays ].
	pos ifNotNil: [ stream position: pos ]
]

{ #category : #chunks }
RMDAPNGWriter >> write_fcTL: aForm offset: aPoint delay: anInteger [

	self writeChunk: 'fcTL' streamContents: [ :byteStream | 
		byteStream
			nextInt32Put: sequenceNumber;
			nextInt32Put: aForm width;
			nextInt32Put: aForm height;
			nextInt32Put:
				(aPoint ifNil: [ 0 ] ifNotNil: [ aPoint x asInteger ]);
			nextInt32Put:
				(aPoint ifNil: [ 0 ] ifNotNil: [ aPoint y asInteger ]);
			nextNumber: 2 put: (anInteger ifNil: [ 0 ] ifNotNil: #asInteger);
			nextNumber: 2 put: 60;
			nextPut: disposeOp;
			nextPut: blendOp ].

	sequenceNumber := sequenceNumber + 1.
	numFrames := numFrames + 1
]

{ #category : #chunks }
RMDAPNGWriter >> write_fdAT: aForm [

	self writeChunk: 'fdAT' streamContents: [ :byteStream | 
		byteStream nextInt32Put: sequenceNumber.
		self frameDataFrom: aForm writeInto: byteStream ].
	sequenceNumber := sequenceNumber + 1
]
