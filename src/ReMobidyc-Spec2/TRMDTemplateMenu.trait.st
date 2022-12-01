Trait {
	#name : #TRMDTemplateMenu,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #menu }
TRMDTemplateMenu >> addRandomDistributionTemplatesToMenu: aSpMenuPresenter [

	aSpMenuPresenter addGroup: [ :group | 
		self randomDistributions do: [ :sourceTemplate | 
			sourceTemplate addToMenu: group for: self ] ]
]

{ #category : #menu }
TRMDTemplateMenu >> expressionTemplateMenu [

	| menu |
	menu := SpMenuPresenter new.
	self addRandomDistributionTemplatesToMenu: menu.
	^ menu
]

{ #category : #templates }
TRMDTemplateMenu >> randomDistributions [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'uniform distribution'
					   description: 'Usage: uniform x to y' , String cr
						   ,
							   'a directive to generate a random number in the uniform distribution between x and y'
						   , String cr , 'Note: The units of x and y must agree.'
					   sourceText: 'uniform ... to ...');
			  nextPut: (RMDSourceTemplate
					   name: 'normal distribution'
					   description: 'Usage: normal x sigma y' , String cr
						   ,
							   'a directive to generate a random number in the normal distribution with mean=x, sigma=y'
						   , String cr , 'Note: The units of x and y must agree.'
					   sourceText: 'normal ... sigma ...');
			  nextPut: (RMDSourceTemplate
					   name: 'gamma distribution'
					   description: 'Usage: gamma x scale y' , String cr
						   ,
							   'a directive to generate a random number in the gamma distribution with shape=x, scale=y'
						   , String cr , 'Note: x and y must have no unit.'
					   sourceText: 'gamma ... scale ...');
			  nextPut: (RMDSourceTemplate
					   name: 'log-logistic distribution'
					   description: 'Usage: loglogistic x shape y' , String cr
						   ,
							   'a directive to generate a random number in the log-logistic distribution with scale=x, shape=y'
						   , String cr , 'Note: x and y must have no unit.'
					   sourceText: 'loglogistic ... shape ...') ]
]

{ #category : #menu }
TRMDTemplateMenu >> templateMenu [

	| menu |
	menu := SpMenuPresenter new
		        addItem: [ :item | 
			        item
				        name: 'Expressions...';
				        subMenu: self expressionTemplateMenu ];
		        yourself.
	^ menu
]
