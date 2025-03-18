Class {
	#name : 'ReMobidycCommandLineHandler',
	#superclass : 'CommandLineHandler',
	#category : 'ReMobidyc-Application',
	#package : 'ReMobidyc-Application'
}

{ #category : 'accessing' }
ReMobidycCommandLineHandler class >> commandName [

	^ 're:mobidyc'
]

{ #category : 'accessing' }
ReMobidycCommandLineHandler class >> generate [

	<script>
	PhleeterOnOSX new
		properties: {
				(#AppName -> 'remobidyc').
				(#InfoString -> 're:mobidyc').
				(#BundleIdentifier -> 'com.github.remobidyc.remobidyc').
				(#ShortVersion -> BaselineOfReMobidyc codename).
				(#DisplayName -> ('re:mobidyc ' , BaselineOfReMobidyc codename)).
				(#CodesignName -> 'ReMobidyc').
				(#IconSetFile
				 ->
					 ((IceRepository repositoryNamed: 'ReMobidyc') location
					  / 'images' / 'remobidyc.icns')).
				(#DiskIconSetFile
				 ->
					 ((IceRepository repositoryNamed: 'ReMobidyc') location
					  / 'images' / 'remobidyc-disk.icns')).
				(#CommandLineHandler -> self commandName).
				(#CompanyName -> 're:mobidyc project').
				(#DeployPharoExpression -> 'BaselineOfReMobidyc deploy') }
				asDictionary;
		outputDirectory: FileLocator home / 'src' / 'ReMobidyc' / 'build';
		targetPlatforms:
			#( 'Darwin-arm64' 'Darwin-x86_64' 'Windows-x86_64' );
		addExternalDirectory:
			(IceRepository repositoryNamed: 'ReMobidyc') location / 'resources'
			/ 'Fonts';
		addExternalDirectory:
			(IceRepository repositoryNamed: 'ReMobidyc') location / 'docs'
			/ 'cheatsheets'
		destination: 'pharo-local/ReMobidyc/';
		addExternalDirectory:
			FileLocator localDirectory / 'ReMobidyc' / 'logos'
		destination: 'pharo-local/ReMobidyc/';
		generate
]

{ #category : 'activation' }
ReMobidycCommandLineHandler >> activate [

	self installMenu.
	BaselineOfReMobidyc ensureStandardRepository.
	RMDLauncher new open
]

{ #category : 'utilities' }
ReMobidycCommandLineHandler >> installMenu [

	OSWindowDriver current startUp: true.
	OSPlatform current isMacOSX ifTrue: [
		| main |
		main := CocoaMenu new.
		main
			title: 'MainMenu';
			addSubmenu: 're:mobidyc' with: [ :m |
				m
					addItemWithTitle: 'Settings...'
					action: [ BaselineOfReMobidyc showSettingsBrowser ];
					addItemWithTitle: 'About...' action: [ RMDAbout open ];
					addItemWithTitle: 'Quit'
					action: [ Smalltalk snapshot: false andQuit: true ]
					shortcut: 'q' ];
			addSubmenu: 'File' with: [ :m |
			m
				addItemWithTitle: 'Open Launcher'
				action: [ RMDLauncher new open ];
				addItemWithTitle: 'Open Modeler' action: [
					(RMDSimulationModeler on: (RMDSimulationModel new
								  addRenderer: (RMDBackgroundColorRenderer color: Color black);
								  addRenderer: (RMDPatchColorAlphaRenderer
										   color: Color green
										   alpha: '0.5' asRMDExpression
										   between: '0.0' asRMDExpression
										   and: '1.0' asRMDExpression);
								  yourself)) open ] ];
			addSubmenu: 'Help' with: [ :m |
			m
				addItemWithTitle: 'Cheatsheets...'
				action: [ BaselineOfReMobidyc showCheatsheets ]
				shortcut: '';
				addItemWithTitle: 'Tutorial...'
				action: [ BaselineOfReMobidyc showTutorial ] ].
		main setAsMainMenu ]
]
