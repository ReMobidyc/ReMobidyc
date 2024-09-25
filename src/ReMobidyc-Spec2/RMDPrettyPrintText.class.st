Class {
	#name : 'RMDPrettyPrintText',
	#superclass : 'RSLabel',
	#category : 'ReMobidyc-Spec2-PrettyPrint',
	#package : 'ReMobidyc-Spec2',
	#tag : 'PrettyPrint'
}

{ #category : 'instance creation' }
RMDPrettyPrintText class >> agent: aString [

	^ self new
		  text: aString;
		  fontFamily: 'Lucida Grande';
		  fontSize: self fontSize;
		  color: Color darkGray;
		  yourself
]

{ #category : 'accessing' }
RMDPrettyPrintText class >> fontSize [

	^ 12
]

{ #category : 'instance creation' }
RMDPrettyPrintText class >> identifier: aString [

	^ self new
		  text: aString;
		  fontFamily: 'Lucida Grande';
		  fontSize: self fontSize;
		  color: Color darkGray;
		  yourself
]

{ #category : 'instance creation' }
RMDPrettyPrintText class >> keyword: aString [

	^ self new
		  text: aString;
		  fontSize: self fontSize;
		  color: Color black;
		  italic;
		  yourself
]

{ #category : 'instance creation' }
RMDPrettyPrintText class >> literal: aString [

	^ self new
		  text: aString;
		  fontFamily: 'Lucida Grande';
		  fontSize: self fontSize;
		  color: Color darkGray;
		  yourself
]

{ #category : 'instance creation' }
RMDPrettyPrintText class >> operator: aString [

	^ self new
		  text: aString;
		  fontFamily: 'Lucida Grande';
		  fontSize: self fontSize;
		  color: Color darkGray;
		  yourself
]

{ #category : 'instance creation' }
RMDPrettyPrintText class >> unit: aString [

	^ self new
		  text: aString;
		  fontFamily: 'Lucida Grande';
		  fontSize: self fontSize;
		  color: Color gray;
		  yourself
]

{ #category : 'positioning' }
RMDPrettyPrintText >> , aRMDPrettyPrintText [

	aRMDPrettyPrintText translateMiddleLeftTo:
		self encompassingRectangle rightCenter + (self margin @ 0).
	^ aRMDPrettyPrintText
]

{ #category : 'accessing' }
RMDPrettyPrintText >> margin [

	^ 4
]
