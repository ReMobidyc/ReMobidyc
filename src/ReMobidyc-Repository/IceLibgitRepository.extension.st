Extension { #name : #IceLibgitRepository }

{ #category : #'*ReMobidyc-Repository' }
IceLibgitRepository >> isReMobidycRepository [

	^ self location
		  ifNotNil: [ :location | 
			  (location / 'models') isDirectory or: [ 
				  (location / 'actions') isDirectory or: [ 
					  (location / 'icons') isDirectory ] ] ]
		  ifNil: [ false ]
]
