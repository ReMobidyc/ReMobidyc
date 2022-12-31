Class {
	#name : #RMDMetadata,
	#superclass : #Object,
	#instVars : [
		'name',
		'author',
		'date',
		'description'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #'instance creation' }
RMDMetadata class >> fromJsonString: aString [

	^ self new readFromJsonString: aString
]

{ #category : #converting }
RMDMetadata >> asJsonObject [

	^ Dictionary new
		  at: self nameField put: name;
		  at: self authorField put: author;
		  at: self dateField put: (date ifNotNil: #asString);
		  at: self descriptionField put: description;
		  yourself
]

{ #category : #converting }
RMDMetadata >> asJsonString [

	^ String streamContents: [ :stream | self printJsonOn: stream ]
]

{ #category : #converting }
RMDMetadata >> asText [

	^ name asText allBold , (String streamContents: [ :stream | 
		   stream
			   cr;
			   nextPutAll: 'author: ';
			   nextPutAll: author;
			   cr;
			   nextPutAll: 'date: ';
			   nextPutAll: self dateString;
			   cr;
			   cr;
			   nextPutAll: description ]) asText
]

{ #category : #accessing }
RMDMetadata >> author [

	^ author
]

{ #category : #accessing }
RMDMetadata >> author: aString [

	author := aString
]

{ #category : #accessing }
RMDMetadata >> authorField [

	^ 'author'
]

{ #category : #accessing }
RMDMetadata >> date [

	^ date
]

{ #category : #accessing }
RMDMetadata >> date: aDateAndTime [

	date := aDateAndTime isString
		        ifTrue: [ 
			        [ DateAndTime fromString: aDateAndTime ]
				        on: Error
				        do: [ :ex | nil ] ]
		        ifFalse: [ aDateAndTime ]
]

{ #category : #accessing }
RMDMetadata >> dateField [

	^ 'date'
]

{ #category : #accessing }
RMDMetadata >> dateString [

	^ String streamContents: [ :stream | 
		  date
			  ifNotNil: [ 
				  BasicDatePrinter default
					  printYMD: date
					  withLeadingSpace: false
					  on: stream.
				  stream space.
				  BasicDatePrinter default
					  printHMS: date
					  separatedBy: $:
					  on: stream.
				  stream
					  space;
					  nextPut: $(;
					  nextPut: (date offset positive
							   ifTrue: [ $+ ]
							   ifFalse: [ $- ]).
				  date offset hours abs
					  printOn: stream
					  base: 10
					  length: 2
					  padded: true.
				  stream nextPut: $:.
				  date offset minutes abs
					  printOn: stream
					  base: 10
					  length: 2
					  padded: true.
				  date offset seconds = 0 ifFalse: [ 
					  stream
						  nextPut: $:;
						  print: date offset seconds abs truncated ].
				  stream nextPut: $) ]
			  ifNil: [ stream nextPutAll: 'N/A' ] ]
]

{ #category : #defaults }
RMDMetadata >> defaultAuthor [
	^ ''
]

{ #category : #defaults }
RMDMetadata >> defaultDate [

	^ nil
]

{ #category : #defaults }
RMDMetadata >> defaultDescription [
	^ ''
]

{ #category : #defaults }
RMDMetadata >> defaultName [
	^ ''
]

{ #category : #accessing }
RMDMetadata >> description [

	^ description
]

{ #category : #accessing }
RMDMetadata >> description: aString [

	description := aString
]

{ #category : #accessing }
RMDMetadata >> descriptionField [

	^ 'description'
]

{ #category : #initialization }
RMDMetadata >> initialize [

	super initialize.
	name := self defaultName.
	author := self defaultAuthor.
	date := self defaultDate.
	description := self defaultDescription
]

{ #category : #accessing }
RMDMetadata >> name [

	^ name
]

{ #category : #accessing }
RMDMetadata >> name: aString [

	name := aString
]

{ #category : #accessing }
RMDMetadata >> nameField [

	^ 'name'
]

{ #category : #printing }
RMDMetadata >> printJsonOn: aStream [

	STONJSON put: self asJsonObject onStreamPretty: aStream
]

{ #category : #printing }
RMDMetadata >> printOn: aStream [

	aStream nextPutAll: name.
	author ifNotEmpty: [ 
		aStream
			nextPutAll: ' by ';
			nextPutAll: author ]
]

{ #category : #converting }
RMDMetadata >> readFromJsonObject: aDictionary [

	aDictionary isDictionary ifFalse: [ ^ self ].
	self
		name:
			(aDictionary at: self nameField ifAbsent: [ self defaultName ]);
		author:
			(aDictionary at: self authorField ifAbsent: [ self defaultAuthor ]);
		date:
			(aDictionary at: self dateField ifAbsent: [ self defaultAuthor ]);
		description: (aDictionary
				 at: self descriptionField
				 ifAbsent: [ self defaultAuthor ])
]

{ #category : #converting }
RMDMetadata >> readFromJsonString: aString [

	self readFromJsonObject: ([ STONJSON fromString: aString ]
			 on: Error
			 do: [ :ex | nil ])
]
