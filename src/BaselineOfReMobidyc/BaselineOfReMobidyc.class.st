Class {
	#name : #BaselineOfReMobidyc,
	#superclass : #BaselineOf,
	#category : #BaselineOfReMobidyc
}

{ #category : #baselines }
BaselineOfReMobidyc >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'PetitParser2Core'
				with: [ spec repository: 'github://kursjan/petitparser2/' ].
			spec
				package: 'ReMobidyc-Storage';
				package: 'ReMobidyc-Units' with: [ spec requires: #() ];
				package: 'ReMobidyc-Language'
					with: [ spec requires: #('PetitParser2Core' 'ReMobidyc-Units') ];
				package: 'ReMobidyc-Interpreter'
					with: [ spec requires: #('ReMobidyc-Storage' 'ReMobidyc-Language') ];
				package: 'ReMobidyc-Visualization'
					with: [ spec
						requires: #('ReMobidyc-Language' 'ReMobidyc-Interpreter' 'ReMobidyc-Storage') ];
				package: 'ReMobidyc-Repository'
					with: [ spec requires: #('ReMobidyc-Language') ];
				package: 'ReMobidyc-Spec2'
					with: [ spec
						requires:
							#('ReMobidyc-Language' 'ReMobidyc-Interpreter' 'ReMobidyc-Units' 'ReMobidyc-Visualization' 'ReMobidyc-Repository') ];
				package: 'ReMobidyc-Storage-Tests'
					with: [ spec requires: #('ReMobidyc-Storage') ];
				package: 'ReMobidyc-Language-Tests'
					with: [ spec requires: #('ReMobidyc-Language') ];
				package: 'ReMobidyc-Units-Tests'
					with: [ spec requires: #('ReMobidyc-Units') ];
				package: 'ReMobidyc-Visualization-Tests'
					with: [ spec requires: #('ReMobidyc-Visualization' 'ReMobidyc-Language') ];
				package: 'ReMobidyc-Interpreter-Tests'
					with:
						[ spec requires: #('ReMobidyc-Language-Tests' 'ReMobidyc-Interpreter') ].
			spec
				group: 'default' with: #('core' 'tests');
				group: 'core'
					with:
					#('ReMobidyc-Storage' 'ReMobidyc-Language' 'ReMobidyc-Units' 'ReMobidyc-Interpreter' 'ReMobidyc-Visualization' 'ReMobidyc-Repository' 'ReMobidyc-Spec2');
				group: 'tests'
					with:
					#('ReMobidyc-Storage-Tests' 'ReMobidyc-Language-Tests' 'ReMobidyc-Units-Tests' 'ReMobidyc-Interpreter-Tests').
			spec postLoadDoIt: #postLoad ]
]

{ #category : #scripts }
BaselineOfReMobidyc >> installLogos [
	| imagesUrl basenames client |
	imagesUrl := 'https://github.com/tomooda/ReMobidyc/raw/main/images'
		asUrl.
	basenames := #('logo-light1.png' 'logo-light2.png' 'logo-dark1.png' 'logo-dark2.png' 'default.png').
	client := ZnClient new.
	basenames
		do: [ :basename | 
			(self logoDirectoryPath / basename) exists
				ifFalse: [ | response |
					response := client
						url: imagesUrl / basename;
						get;
						response.
					(response isSuccess
						and: [ response entity contentType sub = 'png' ])
						ifTrue: [ self logoDirectoryPath / basename
								binaryWriteStreamDo: [ :writeStream | response entity writeOn: writeStream ] ] ] ]
]

{ #category : #scripts }
BaselineOfReMobidyc >> logoDirectoryPath [
	^ (FileLocator localDirectory / 'ReMobidyc' / 'logos')
		ensureCreateDirectory
]

{ #category : #scripts }
BaselineOfReMobidyc >> postLoad [
	<script: 'BaselineOfReMobidyc new postLoad'>
	self installLogos.
	PharoLightTheme beCurrent.
	PolymorphSystemSettings desktopLogoFileName: ''.
	PolymorphSystemSettings
		desktopLogoFileName: (self logoDirectoryPath / 'default.png') fullName
]
