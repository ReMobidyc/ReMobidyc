Class {
	#name : #RMDMetadata,
	#superclass : #Object,
	#instVars : [
		'name',
		'authors',
		'date',
		'description'
	],
	#classVars : [
		'CurrentAuthor'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #accessing }
RMDMetadata class >> currentAuthor [

	[ CurrentAuthor isNil ] whileTrue: [ self renewCurrentAuthor ].
	^ CurrentAuthor
]

{ #category : #accessing }
RMDMetadata class >> flushCurrentAuthor [

	CurrentAuthor := nil
]

{ #category : #'instance creation' }
RMDMetadata class >> fromJsonObject: aDictionary [

	^ self new readFromJsonObject: aDictionary
]

{ #category : #'instance creation' }
RMDMetadata class >> fromJsonStream: aStream [

	^ self fromJsonObject: (STONJSON fromStream: aStream)
]

{ #category : #'instance creation' }
RMDMetadata class >> fromJsonString: aString [

	^ self fromJsonObject: (STONJSON fromString: aString)
]

{ #category : #accessing }
RMDMetadata class >> guessUserName [

	(OSEnvironment current at: 'USER' ifAbsent: [ nil ]) ifNotNil: [ :n | 
		^ n ].
	(OSEnvironment current at: 'USERNAME' ifAbsent: [ nil ]) ifNotNil: [ 
		:n | ^ n ].
	^ 'Anonymous'
]

{ #category : #menus }
RMDMetadata class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Upgrade)
		parent: #ReMobidycSystem;
		order: 10;
		label: 'Forget current user';
		action: [ self flushCurrentAuthor ];
		help: 'Forget the current user''s name as an author of models'
]

{ #category : #accessing }
RMDMetadata class >> renewCurrentAuthor [

	(UIManager default
		 request: 'Your name?'
		 initialAnswer: self guessUserName) ifNotNil: [ :n | 
		n trim ifNotEmpty: [ :author | CurrentAuthor := author ] ].
	^ CurrentAuthor
]

{ #category : #converting }
RMDMetadata >> asJsonObject [

	^ Dictionary new
		  at: self nameField put: name;
		  at: self authorsField put: authors;
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
			   nextPutAll: 'authors: ';
			   nextPutAll: (', ' join: authors);
			   cr;
			   nextPutAll: 'date: ';
			   nextPutAll: self dateString;
			   cr;
			   cr;
			   nextPutAll: description ]) asText
]

{ #category : #accessing }
RMDMetadata >> authors [

	^ authors
]

{ #category : #accessing }
RMDMetadata >> authors: aString [

	authors := aString
]

{ #category : #accessing }
RMDMetadata >> authorsField [

	^ 'authors'
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
RMDMetadata >> defaultAuthors [

	^ {  }
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

{ #category : #operations }
RMDMetadata >> ensureAuthor: aString [

	aString trim ifNotEmpty: [ :author | 
		(authors includes: author) ifFalse: [ 
			authors := authors , { author } ] ]
]

{ #category : #operations }
RMDMetadata >> ensureCurrentAuthor [

	^ self ensureAuthor: self class currentAuthor
]

{ #category : #initialization }
RMDMetadata >> initialize [

	super initialize.
	name := self defaultName.
	authors := self defaultAuthors.
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
	authors ifNotEmpty: [ 
		aStream nextPutAll: ' by '.
		authors
			do: [ :author | aStream nextPutAll: author ]
			separatedBy: [ aStream nextPutAll: ', ' ] ]
]

{ #category : #converting }
RMDMetadata >> readFromJsonObject: aDictionary [

	aDictionary isDictionary ifFalse: [ ^ self ].
	self
		name:
			(aDictionary at: self nameField ifAbsent: [ self defaultName ]);
		authors:
			(aDictionary
				 at: self authorsField
				 ifAbsent: [ self defaultAuthors ]);
		date:
			(aDictionary at: self dateField ifAbsent: [ self defaultDate ]);
		description: (aDictionary
				 at: self descriptionField
				 ifAbsent: [ self defaultDescription ])
]

{ #category : #converting }
RMDMetadata >> readFromJsonString: aString [

	self readFromJsonObject: ([ STONJSON fromString: aString ]
			 on: Error
			 do: [ :ex | nil ])
]

{ #category : #operations }
RMDMetadata >> updateDate [

	date := DateAndTime now
]
