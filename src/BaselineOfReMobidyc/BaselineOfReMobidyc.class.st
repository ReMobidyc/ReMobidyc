Class {
	#name : 'BaselineOfReMobidyc',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfReMobidyc',
	#package : 'BaselineOfReMobidyc'
}

{ #category : 'accessing' }
BaselineOfReMobidyc class >> codename [

	^ 'nowhere'
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

{ #category : 'scripts' }
BaselineOfReMobidyc class >> ensureStandardRepository [

	<script: 'BaselineOfReMobidyc  ensureStandardRepository'>
	^ IceRepository repositories
		  detect: [ :repo | repo name = 'StandardModels' ]
		  ifNone: [
			  | location repo |
			  location := FileLocator localDirectory / 'iceberg' / 'ReMobidyc'
			              / 'StandardModels'.
			  location isDirectory
				  ifTrue: [
					  repo := IceRepositoryCreator new
						          repository: nil;
						          location: location;
						          createRepository ]
				  ifFalse: [
					  UIManager default
						  informUser: 'Cloning the official re:mobidyc standard models'
						  during: [
							  repo := IceRepositoryCreator new
								          repository: nil;
								          remote:
									          (IceGitRemote url:
											           'https://github.com/ReMobidyc/StandardModels.git');
								          location: location;
								          createRepository ] ].
			  repo
				  register;
				  yourself ]
]

{ #category : 'utilities' }
BaselineOfReMobidyc class >> icon [

	^ self logo scaledToSize: 24 @ 24
]

{ #category : 'scripts' }
BaselineOfReMobidyc class >> initializeResources [

	<script: 'BaselineOfReMobidyc initializeResources'>
	self installLogos.
	PharoLightTheme beCurrent.
	PolymorphSystemSettings desktopLogoFileName: ''.
	PolymorphSystemSettings desktopLogoFileName:
		(self logoDirectoryPath / 'default.png') fullName.
	PolymorphSystemSettings desktopColor:
		(Color cyan mixed: 0.02 with: Color white).
	Smalltalk at: #RMDFileMemory ifPresent: [ :class | class initialize ]
]

{ #category : 'scripts' }
BaselineOfReMobidyc class >> installDocuments [

	<script>
	(IceRepository repositoryNamed: 'ReMobidyc') ifNotNil: [ :repo |
		repo location / 'docs' / 'cheatsheets' copyAllTo:
			(FileLocator localDirectory / 'ReMobidyc' / 'docs' / 'cheatsheets')
				ensureCreateDirectory.
		repo location / 'Tutorials' / 'Grasshoppers' copyAllTo:
			(FileLocator localDirectory / 'ReMobidyc' / 'Tutorials'
			 / 'Grasshoppers') ensureCreateDirectory ]
]

{ #category : 'scripts' }
BaselineOfReMobidyc class >> installFonts [

	<script: 'BaselineOfReMobidyc installFonts'>
	(IceRepository repositoryNamed: 'ReMobidyc') ifNotNil: [ :repo |
		repo location / 'resources' / 'Fonts' copyAllTo:
			(FileLocator imageDirectory / 'Fonts') ensureCreateDirectory.
		Smalltalk at: #PlemolJPRegular ifPresent: [ :fontClass |
			EmbeddedFreeTypeFontInstaller registerFont: fontClass.
			FreeTypeFontProvider current buildFamilies.
			StandardFonts setAllStandardFontsTo:
				(LogicalFont familyName: 'PlemolJP' pointSize: 10) ] ]
]

{ #category : 'scripts' }
BaselineOfReMobidyc class >> installIcons [

	<script: 'BaselineOfReMobidyc installIcons'>
	(IceRepository repositoryNamed: 'ReMobidyc') ifNotNil: [ :repo |
		repo location / 'resources' / 'icons' copyAllTo:
			(FileLocator localDirectory / 'ReMobidyc' / 'icons')
				ensureCreateDirectory ]
]

{ #category : 'scripts' }
BaselineOfReMobidyc class >> installLogos [
	| imagesUrl basenames client |
	imagesUrl := 'https://github.com/ReMobidyc/ReMobidyc/raw/main/images'
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

{ #category : 'utilities' }
BaselineOfReMobidyc class >> logo [

	^ Form fromFileNamed: self logoDirectoryPath / 'default.png'
]

{ #category : 'scripts' }
BaselineOfReMobidyc class >> logoDirectoryPath [
	^ (FileLocator localDirectory / 'ReMobidyc' / 'logos')
		ensureCreateDirectory
]

{ #category : 'menus' }
BaselineOfReMobidyc class >> remobidycMenuOn: aBuilder [

	<remobidycMenu>
	(aBuilder item: #ReMobidycDocuments)
		order: 80;
		label: 'Documents';
		iconName: #book;
		with: [
				(aBuilder item: #ReMobidycCheatsheets)
					label: 'Cheatsheets...';
					iconName: #help;
					order: 10;
					action: [ self showCheatsheets ];
					help: 'Open cheatsheets browser for re:mobidyc'.
				(aBuilder item: #ReMobidycTutorial)
					label: 'Grasshopper Tutorial';
					iconName: #bookmark;
					order: 20;
					action: [ self showTutorial ];
					help: 'Open a tutorial to build a model of grasshoppers and eggs' ].
	(aBuilder item: #ReMobidycSystem)
		order: 100;
		label: 'System';
		iconName: #haloDebug;
		with: [
				(aBuilder item: #ReMobidycSettings)
					label: 'Settings...';
					iconName: #preferences;
					order: 0;
					action: [ self showSettingsBrowser ];
					help: 'Open a settings browser for re:mobidyc' ]
]

{ #category : 'settings' }
BaselineOfReMobidyc class >> settingOn: aBuilder [

	<systemsettings>
	(aBuilder group: #remobidyc)
		label: 're:mobidyc';
		description: 'All settings about re:mobidyc'
]

{ #category : 'utilities' }
BaselineOfReMobidyc class >> showCheatsheets [

	<script>
	| documentBrowser |
	documentBrowser := MicDocumentBrowserPresenter new.
	documentBrowser documentRoots
		removeAll;
		addAll:
			((FileLocator localDirectory / 'ReMobidyc' / 'docs' / 'cheatsheets'
				  filesMatching: '*.md') collect: #asMicResourceReference).
	documentBrowser open
]

{ #category : 'settings' }
BaselineOfReMobidyc class >> showSettingsBrowser [

	<script: 'BaselineOfReMobidyc showSettingsBrowser'>
	SettingBrowser new
		changePackageSet:
			(PackageOrganizer default packages select: [ :package |
					 package name beginsWith: 'ReMobidyc-' ]);
		open
]

{ #category : 'utilities' }
BaselineOfReMobidyc class >> showTutorial [

	<script>
	| documentBrowser |
	documentBrowser := MicDocumentBrowserPresenter new.
	documentBrowser documentRoots
		removeAll;
		addAll: ((FileLocator localDirectory / 'ReMobidyc' / 'Tutorials'
			  / 'Grasshoppers' filesMatching: '*.md') collect:
					 #asMicResourceReference).
	documentBrowser open
]

{ #category : 'utilities' }
BaselineOfReMobidyc class >> updateFromOfficialRepository [

	<script: 'BaselineOfReMobidyc updateFromOfficialRepository'>
	| repository |
	repository := self ensureIcebergRepository.
	[ repository pull ]
		on: IceExperimentalFeature
		do: [ :ex | ex load ].
	[ (repository packageNamed: 'BaselineOfReMobidyc') load ]
		on: MCMergeOrLoadWarning
		do: [ :ex | ex load ].
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

{ #category : 'menus' }
BaselineOfReMobidyc class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycDocuments)
		parent: 'ReMobidyc';
		order: 80;
		label: 'Documents';
		with: [
			(aBuilder item: #ReMobidycCheatsheets)
				order: 10;
				label: 'Cheatsheets...';
				action: [ self showCheatsheets ];
				help: 'Open cheatsheets browser for re:mobidyc'.
			(aBuilder item: #ReMobidycTutorial)
				order: 20;
				label: 'Grasshopper Tutorial';
				action: [ self showTutorial ];
				help: 'Open a tutorial to build a model of grasshoppers and eggs' ].
	(aBuilder item: #ReMobidycSystem)
		parent: 'ReMobidyc';
		order: 100;
		label: 'System';
		with: [
			(aBuilder item: #ReMobidycSettings)
				order: 0;
				label: 'Settings...';
				action: [ self showSettingsBrowser ];
				help: 'Open a settings browser for re:mobidyc'.
			(aBuilder item: #Upgrade)
				order: 100;
				label: 'Upgrade from the official repository';
				action: [ self updateFromOfficialRepository ];
				help:
					'Upgrade the re:mobidyc from the official github repository.' ]
]

{ #category : 'baselines' }
BaselineOfReMobidyc >> baselineOf: spec [

	<baseline>
	spec for: #common do: [
			spec
				baseline: 'Micromaid'
				with: [ spec repository: 'github://tomooda/Micromaid:main/' ];
				baseline: 'Phleeter'
				with: [ spec repository: 'github://tomooda/Phleeter:main/' ];
				baseline: 'HiDeHo'
				with: [ spec repository: 'github://tomooda/HiDeHo:main/' ];
				baseline: 'PetitParser2Core'
				with: [ spec repository: 'github://kursjan/petitparser2/' ];
				baseline: 'DataFrame'
				with: [ spec repository: 'github://PolyMathOrg/DataFrame/' ].
			spec
				package: 'ReMobidyc-Application'
				with: [ spec requires: #( 'Phleeter' ) ];
				package: 'ReMobidyc-Chronicle'
				with: [ spec requires: #( 'HiDeHo' 'ReMobidyc-Interpreter' ) ];
				package: 'ReMobidyc-Diagrams'
				with: [ spec requires: #( 'Micromaid' 'ReMobidyc-Interpreter' ) ];
				package: 'ReMobidyc-Storage';
				package: 'ReMobidyc-DataSource'
				with: [ spec requires: #( 'DataFrame' ) ];
				package: 'ReMobidyc-Units' with: [ spec requires: #(  ) ];
				package: 'ReMobidyc-Language'
				with: [ spec requires: #( 'PetitParser2Core' 'ReMobidyc-Units' ) ];
				package: 'ReMobidyc-Interpreter' with: [
						spec requires:
								#( 'ReMobidyc-Storage' 'ReMobidyc-Language'
								   'ReMobidyc-DataSource' ) ];
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
					spec requires:
							#( 'ReMobidyc-Visualization' 'ReMobidyc-Language' ) ];
				package: 'ReMobidyc-Interpreter-Tests' with: [
						spec requires:
								#( 'ReMobidyc-Language-Tests' 'ReMobidyc-Interpreter' ) ].
			spec
				group: 'default' with: #( 'core' 'tests' );
				group: 'core'
				with:
					#( 'ReMobidyc-Application' 'ReMobidyc-Chronicle'
					   'ReMobidyc-Diagrams' 'ReMobidyc-Storage' 'ReMobidyc-Language'
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
BaselineOfReMobidyc >> postLoad [

	<script: 'BaselineOfReMobidyc new postLoad'>
	self class
		initializeResources;
		ensureStandardRepository;
		installFonts;
		installIcons;
		installDocuments
]
