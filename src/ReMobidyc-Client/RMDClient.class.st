Class {
	#name : #RMDClient,
	#superclass : #Object,
	#instVars : [
		'serverUrl',
		'tokens',
		'username',
		'hostname'
	],
	#classVars : [
		'Servers'
	],
	#category : #'ReMobidyc-Client'
}

{ #category : #defaults }
RMDClient class >> defaultServers [
	^ Array new
]

{ #category : #'instance creation' }
RMDClient class >> forLocalServer [
	<script: 'RMDClient forLocalServer'>
	Servers := {self localServer}
]

{ #category : #'instance creation' }
RMDClient class >> forNone [
	<script: 'RMDClient forNone'>
	Servers := {}
]

{ #category : #'instance creation' }
RMDClient class >> forPublicServer [
	<script: 'RMDClient forPublicServer'>
	Servers := {self publicServer}
]

{ #category : #services }
RMDClient class >> informModel: aString progress: aNumber from: aRMDObservatory [
	self
		serversDo:
			[ :server | server informModel: aString progress: aNumber from: aRMDObservatory ]
]

{ #category : #'instance creation' }
RMDClient class >> localServer [
	^ self on: 'http://localhost:2222/'
]

{ #category : #'instance creation' }
RMDClient class >> on: aZnUrl [
	^ self new
		serverUrl: aZnUrl;
		yourself
]

{ #category : #'instance creation' }
RMDClient class >> publicServer [
	^ self on: 'https://remobidyc.viennatalk.org/'
]

{ #category : #services }
RMDClient class >> serversDo: aBlock [
	(Servers ifNil: [ Servers := self defaultServers ]) do: aBlock
]

{ #category : #accessing }
RMDClient >> guessHostname [
	^ NetNameResolver localHostName
]

{ #category : #accessing }
RMDClient >> guessUsername [
	^ Smalltalk os environment at: 'USER' ifAbsent: [ 'anonymous' ]
]

{ #category : #accessing }
RMDClient >> hostname [
	^ hostname ifNil: [ hostname := self requestHostname ]
]

{ #category : #accessing }
RMDClient >> hostname: aString [
	hostname := aString
]

{ #category : #networking }
RMDClient >> informModel: aString progress: aNumber from: aRMDObservatory [
	| runInfo |
	runInfo := tokens
		at: aRMDObservatory identityHash
		ifAbsentPut:
			[ self registerModel: aString progress: aNumber from: aRMDObservatory ].
	runInfo touch.
	[ ZnClient new
		beOneShot;
		method: #PUT;
		url: self serverUrl / 'api' / 'runs' / runInfo runId;
		entity:
			(ZnEntity
				json:
					(NeoJSONWriter
						toString:
							{('username' -> self username).
							('model' -> aString).
							('progress' -> (aNumber * 100.0) asInteger).
							('state' -> 'running').
							('token' -> runInfo token)} asDictionary));
		execute.
	UIManager default
		inform:
			'sent update to ' , self serverUrl printString , '['
				, aNumber asString , ']' ]
		forkAt: Processor userBackgroundPriority
]

{ #category : #initialization }
RMDClient >> initialize [
	super initialize.
	tokens := Dictionary new
]

{ #category : #networking }
RMDClient >> registerModel: aString progress: aNumber from: aRMDObservatory [
	| response |
	response := ZnClient new
		beOneShot;
		method: #POST;
		url: self serverUrl / 'api' / 'register';
		entity:
			(ZnEntity
				json:
					(NeoJSONWriter
						toString:
							{('username' -> self username).
							('model' -> aString).
							('progress' -> (aNumber * 100.0) asInteger).
							('state' -> 'running')} asDictionary));
		execute.
	^ RMDClientRunInfo fromJson: (NeoJSONReader fromString: response)
]

{ #category : #accessing }
RMDClient >> requestHostname [
	^ UIManager default request: 'Hostname' initialAnswer: self guessHostname
]

{ #category : #accessing }
RMDClient >> requestUsername [
	^ UIManager default request: 'Username' initialAnswer: self guessUsername
]

{ #category : #accessing }
RMDClient >> serverUrl [
	^ serverUrl
]

{ #category : #accessing }
RMDClient >> serverUrl: aZnUrl [
	serverUrl := aZnUrl asZnUrl
]

{ #category : #accessing }
RMDClient >> updateInterval [
	^ 10 seconds
]

{ #category : #accessing }
RMDClient >> username [
	^ username ifNil: [ username := self requestUsername ]
]

{ #category : #accessing }
RMDClient >> username: aString [
	username := aString
]
