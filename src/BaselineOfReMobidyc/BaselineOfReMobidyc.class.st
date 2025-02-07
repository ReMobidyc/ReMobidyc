Class {
	#name : 'BaselineOfReMobidyc',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfReMobidyc',
	#package : 'BaselineOfReMobidyc'
}

{ #category : 'utilities' }
BaselineOfReMobidyc class >> deploy [

	<script>
	RMDMetadata flushCurrentAuthor.
	RMDRepositoryDirectory flushCurrent.
	GraphicFontSettings setFontsToStyleNamed: #small.
	Smalltalk cleanUp: true except: {  } confirming: false.
	MCRepositoryGroup allSubInstancesDo: [ :group | 
		group repositories do: [ :repo | group removeRepository: repo ] ].
	IceRepository registry removeAll.
	IceCredentialStore current in: [ :store | 
		store allCredentials do: [ :each | each removeFrom: store ] ].
	World closeAllWindowsDiscardingChanges.
	Deprecation
		raiseWarning: false;
		showWarning: false.
	NoChangesLog install.
	"NoPharoFilesOpener install."
	FFICompilerPlugin install.
	Stdio useNullStreams.
	MCCacheRepository uniqueInstance disable.
	EpMonitor reset.
	self new postLoad.
	5 timesRepeat: [ Smalltalk garbageCollect ]
]

{ #category : 'utilities' }
BaselineOfReMobidyc class >> ensureIcebergRepository [

	^ IceRepository repositories
		  detect: [ :repo | repo name = 'ReMobidyc' ]
		  ifNone: [ 
			  | repo |
			  UIManager default
				  informUser:
				  'Cloning repository from the official re:mobidyc repository'
				  during: [ 
					  repo := IceRepositoryCreator new
						          repository: nil;
						          remote:
							          (IceGitRemote url:
									           'https://github.com/ReMobidyc/ReMobidyc.git');
						          location:
							          FileLocator localDirectory / 'iceberg' / 'ReMobidyc'
							          / 'ReMobidyc';
						          createRepository ].
			  repo
				  register;
				  yourself ]
]

{ #category : 'menus' }
BaselineOfReMobidyc class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycSystem)
		parent: 'ReMobidyc';
		order: 100;
		label: 'System';
		with: [ 
			(aBuilder item: #Upgrade)
				parent: #ReMobidycSystem;
				order: 100;
				label: 'Upgrade from the official repository';
				action: [ self updateFromOfficialRepository ];
				help:
					'Upgrade the re:mobidyc from the official github repository.' ]
]

{ #category : 'utilities' }
BaselineOfReMobidyc class >> updateFromOfficialRepository [

	<script: 'BaselineOfReMobidyc updateFromOfficialRepository'>
	| repository |
	repository := self ensureIcebergRepository.
	repository pull.
	Cursor wait showWhile: [
		| maxCount count |
		maxCount := 5.
		count := 0.
		[
		[
		Metacello new
			repository: 'gitlocal://' , (repository location / 'src') fullName;
			baseline: 'ReMobidyc';
			onConflictUseIncoming;
			onWarningLog;
			load ]
			on: IceExperimentalFeature
			do: [ :ex | ex resume ] ]
			on: Error
			do: [ :ex |
				(count := count + 1) < maxCount
					ifTrue: [
						2 seconds wait.
						ex retry ]
					ifFalse: [ UIManager default alert: 'Failed to update' ] ] ].
	Smalltalk snapshot: true andQuit: false
]

{ #category : 'baselines' }
BaselineOfReMobidyc >> baselineOf: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'HiDeHo'
			with: [ spec repository: 'github://tomooda/HiDeHo:main/' ];
			baseline: 'PetitParser2Core'
			with: [ spec repository: 'github://kursjan/petitparser2/' ];
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/' ].
		spec
			package: 'ReMobidyc-Chronicle'
			with: [ spec requires: #( 'HiDeHo' 'ReMobidyc-Interpreter' ) ];
			package: 'ReMobidyc-Storage';
			package: 'ReMobidyc-DataSource'
			with: [ spec requires: #( 'DataFrame' ) ];
			package: 'ReMobidyc-Units' with: [ spec requires: #(  ) ];
			package: 'ReMobidyc-Language'
			with: [ spec requires: #( 'PetitParser2Core' 'ReMobidyc-Units' ) ];
			package: 'ReMobidyc-Interpreter' with: [
				spec requires:
						#( 'ReMobidyc-Storage' 'ReMobidyc-Language' 'ReMobidyc-DataSource' ) ];
			package: 'ReMobidyc-Visualization' with: [
				spec requires: #( 'ReMobidyc-Language' 'ReMobidyc-Interpreter'
						   'ReMobidyc-Storage' ) ];
			package: 'ReMobidyc-Repository'
			with: [ spec requires: #( 'ReMobidyc-Language' ) ];
			package: 'ReMobidyc-Spec2' with: [
				spec requires: #( 'ReMobidyc-Language' 'ReMobidyc-Interpreter'
						   'ReMobidyc-Units' 'ReMobidyc-Visualization'
						   'ReMobidyc-Repository' ) ];
			package: 'ReMobidyc-Storage-Tests'
			with: [ spec requires: #( 'ReMobidyc-Storage' ) ];
			package: 'ReMobidyc-Language-Tests'
			with: [ spec requires: #( 'ReMobidyc-Language' ) ];
			package: 'ReMobidyc-Units-Tests'
			with: [ spec requires: #( 'ReMobidyc-Units' ) ];
			package: 'ReMobidyc-Visualization-Tests'
			with: [
				spec requires: #( 'ReMobidyc-Visualization'
					   'ReMobidyc-Language' ) ];
			package: 'ReMobidyc-Interpreter-Tests' with: [
				spec requires:
						#( 'ReMobidyc-Language-Tests' 'ReMobidyc-Interpreter' ) ].
		spec
			group: 'default' with: #( 'core' 'tests' );
			group: 'core'
			with:
				#( 'ReMobidyc-Chronicle' 'ReMobidyc-Storage' 'ReMobidyc-Language'
				   'ReMobidyc-Units' 'ReMobidyc-Interpreter'
				   'ReMobidyc-Visualization' 'ReMobidyc-Repository'
				   'ReMobidyc-Spec2' );
			group: 'tests'
			with: #( 'ReMobidyc-Storage-Tests' 'ReMobidyc-Language-Tests'
				   'ReMobidyc-Units-Tests' 'ReMobidyc-Interpreter-Tests'
				   'ReMobidyc-Visualization-Tests' ).
		spec postLoadDoIt: #postLoad ].
	spec for: #'pharo11.x' do: [ spec preLoadDoIt: #installRoassal3 ]
]

{ #category : 'scripts' }
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

{ #category : 'scripts' }
BaselineOfReMobidyc >> installRoassal3 [

	<script: 'BaselineOfReMobidyc new installRoassal3'>
	[
	Metacello new
		baseline: 'Roassal3';
		repository: 'github://ObjectProfile/Roassal3';
		load: 'Full' ]
		on: MCMergeOrLoadWarning
		do: [ :warning | warning load ]
]

{ #category : 'scripts' }
BaselineOfReMobidyc >> installStandardRepository [

	<script: 'BaselineOfReMobidyc new installStandardRepository'>
	^ IceRepository repositories
		  detect: [ :repo | repo name = 'StandardModels' ]
		  ifNone: [ 
			  | repo |
			  UIManager default
				  informUser: 'Cloning the official re:mobidyc standard models'
				  during: [ 
					  repo := IceRepositoryCreator new
						          repository: nil;
						          remote:
							          (IceGitRemote url:
									           'https://github.com/ReMobidyc/StandardModels.git');
						          location:
							          FileLocator localDirectory / 'iceberg' / 'ReMobidyc'
							          / 'StandardModels';
						          createRepository ].
			  repo
				  register;
				  yourself ]
]

{ #category : 'scripts' }
BaselineOfReMobidyc >> logoDirectoryPath [
	^ (FileLocator localDirectory / 'ReMobidyc' / 'logos')
		ensureCreateDirectory
]

{ #category : 'scripts' }
BaselineOfReMobidyc >> postLoad [

	<script: 'BaselineOfReMobidyc new postLoad'>
	self installLogos.
	PharoLightTheme beCurrent.
	PolymorphSystemSettings desktopLogoFileName: ''.
	PolymorphSystemSettings desktopLogoFileName:
		(self logoDirectoryPath / 'default.png') fullName.
	PolymorphSystemSettings desktopColor:
		(Color cyan mixed: 0.02 with: Color white).
	Smalltalk at: #RMDFileMemory ifPresent: [ :class | class initialize ].
	self installStandardRepository
]
