Class {
	#name : 'RMDToggleBorderInteraction',
	#superclass : 'RSInteraction',
	#category : 'ReMobidyc-Spec2-PrettyPrint',
	#package : 'ReMobidyc-Spec2',
	#tag : 'PrettyPrint'
}

{ #category : 'hooks' }
RMDToggleBorderInteraction >> leftClicked: event [

	| shape |
	shape := event shape.
	shape isPrettyPrintNode ifTrue: [
		shape border
			ifNil: [
				shape border: (RSBorder new
						 color: Color lightGray;
						 capRound;
						 width: 3) ]
			ifNotNil: [ shape border: nil ].
		event signalUpdate ]
]

{ #category : 'hooks' }
RMDToggleBorderInteraction >> onShape: aShape [

	aShape removeInteractionIfPresent: self class.
	aShape when: RSMouseLeftClick send: #leftClicked: to: self
]
