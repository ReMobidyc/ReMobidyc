Extension { #name : #RMDLocalFileRepository }

{ #category : #'*ReMobidyc-Spec2' }
RMDLocalFileRepository >> changeDirectory [

	(UIManager default
		 chooseExistingFileReference: 'Repository Directory'
		 extensions: #(  )
		 path:
			 ((FileLocator documents / 'ReMobidyc') ensureCreateDirectory / '*')
				 absolutePath) ifNotNil: [ :ref | self directory: ref ]
]

{ #category : #'*ReMobidyc-Spec2' }
RMDLocalFileRepository >> editMenu [

	^ SpMenuPresenter new
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Rename...';
						  action: [ self rename ] ];
				  addItem: [ :item | 
					  item
						  name: 'Change location...';
						  icon: self icon;
						  action: [ self changeDirectory ] ] ];
		  yourself
]
