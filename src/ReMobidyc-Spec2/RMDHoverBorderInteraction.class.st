Class {
	#name : 'RMDHoverBorderInteraction',
	#superclass : 'RSInteraction',
	#category : 'ReMobidyc-Spec2-PrettyPrint',
	#package : 'ReMobidyc-Spec2',
	#tag : 'PrettyPrint'
}

{ #category : 'hooks' }
RMDHoverBorderInteraction >> mouseEntered: event [

	| shape |
	shape := event shape.
	shape isPrettyPrintNode ifTrue: [
		shape
			border: (RSBorder new
					 color: (Color gray: 0.8);
					 capRound;
					 width: 1);
			color: (Color gray: 0.9).
		event signalUpdate ]
]

{ #category : 'hooks' }
RMDHoverBorderInteraction >> mouseLeft: event [

	| shape |
	shape := event shape.
	shape isPrettyPrintNode ifTrue: [
		shape
			border: nil;
			color: Color transparent.
		event signalUpdate ]
]

{ #category : 'hooks' }
RMDHoverBorderInteraction >> onShape: aShape [

	aShape removeInteractionIfPresent: self class.
	aShape
		when: RSMouseEnter send: #mouseEntered: to: self;
		when: RSMouseLeave send: #mouseLeft: to: self
]
