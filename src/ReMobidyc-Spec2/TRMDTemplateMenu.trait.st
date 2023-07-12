Trait {
	#name : #TRMDTemplateMenu,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #'templates-units' }
TRMDTemplateMenu >> amounts [

	^ Array streamContents: [ :stream | 
		  stream nextPut: (RMDSourceTemplate
				   name: 'mol'
				   description: 'the base SI unit for amount of substance'
				   sourceText: 'mol') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> angles [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'rad (radians)'
					   description: 'π [rad] = 180 [degree]'
					   sourceText: 'rad');
			  nextPut: (RMDSourceTemplate
					   name: 'degree'
					   description: 'π [rad] = 180 [degree]' , String cr
						   ,
							   'Note: quantities in degrees are automatically converted into radians'
					   sourceText: 'degree') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> areas [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'm^2 (squared meters)'
					   description: 'the SI derrived unit for area'
					   sourceText: 'm^2');
			  nextPut: (RMDSourceTemplate
					   name: 'km^2 (squared killo-meters)'
					   description: '1 [km^2] = 10^6 [m^2]'
					   sourceText: 'km^2');
			  nextPut: (RMDSourceTemplate
					   name: 'mm^2 (squared milli-meters)'
					   description: '10^6 [mm^2] = 1 [m^2]'
					   sourceText: 'mm^2');
			  nextPut: (RMDSourceTemplate
					   name: 'ha (hect-are)'
					   description: '1 [ha] = 10^4 [m^2]'
					   sourceText: 'ha');
			  nextPut: (RMDSourceTemplate
					   name: 'a (are)'
					   description: '1 [a] = 10^2 [m^2]'
					   sourceText: 'a');
			  nextPut: (RMDSourceTemplate
					   name: 'ac (acres)'
					   description: '1 [ac] = 4046.8564224 [m^2]'
					   sourceText: 'ac') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> arithmetics [

	^ Array streamContents: [ :stream |
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'remainder'
					   description: 'Usage: expression1 % expression2' , String cr
						   , 'the remainder of expression1 by expression2' , String cr
						   ,
							   'Note: a remainder can be negative when the second argument (modulus) is negative.'
					   sourceText: '_expression1_ % _expression2_');
			  nextPut: (RMDSourceTemplate
					   name: 'raised to'
					   description:
						   'Usage: expression ^ n' , String cr
						   , 'the expression raised to n' , String cr
						   , 'Note: n must be a literal integer (digits)'
					   sourceText: '_expression_ ^ _n_');
			  nextPut: (RMDSourceTemplate
					   name: 'square root'
					   description: 'Usage: sqrt(expression)' , String cr
						   , 'the square root of the given expression' , String cr
						   , 'Note: the expression must be positive or a zero.'
					   sourceText: 'sqrt(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'power'
					   description:
						   'Usage: power(expression1, expression2)' , String cr
						   , 'the power of expression1 to expression2' , String cr
						   ,
							   'Note: the expression1 and the expression 2 must be non-dimensional.'
					   sourceText: 'power(_expression1_, _expression2_)');
			  nextPut: (RMDSourceTemplate
					   name: 'exponential'
					   description:
						   'Usage: exp(expression)' , String cr
						   , 'e powered to the expression' , String cr
						   , 'Note: the expression must be non-dimensional.'
					   sourceText: 'exp(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'natural logarithm'
					   description: 'Usage: ln(expression)' , String cr
						   , 'the natural logarithm of the given expression' , String cr
						   , 'Note: the expression must be positive.'
					   sourceText: 'ln(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'sine'
					   description:
						   'Usage: sin(expression)' , String cr
						   , 'the sine of the expression' , String cr
						   ,
							   'Note: the expression must be an angle (in degree or radian).'
					   sourceText: 'sin(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'cosine'
					   description:
						   'Usage: cos(expression)' , String cr
						   , 'the cosine of the expression' , String cr
						   ,
							   'Note: the expression must be an angle (in degree or radian).'
					   sourceText: 'cos(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'absolute value'
					   description: 'Usage: abs(expression)' , String cr
						   , 'the absolute value of the expression'
					   sourceText: 'abs(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'positive'
					   description: 'Usage: positive(expression)' , String cr
						   , 'zero if negative, otherwise the expression''s value'
					   sourceText: 'positive(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'maximum'
					   description:
						   'Usage: max(expression1, expression2, ..., expression_n)'
						   , String cr , 'the largest value among the arguments'
						   , String cr , 'Note: one or more arguments must be given.'
					   sourceText:
						   'max(_expression1_, _expression2_, ..., _expression_n_)');
			  nextPut: (RMDSourceTemplate
					   name: 'minimum'
					   description:
						   'Usage: min(expression1, expression2, ..., expression_n)'
						   , String cr , 'the least value among the arguments'
						   , String cr , 'Note: one or more arguments must be given.'
					   sourceText:
						   'min(_expression1_, _expression2_, ..., _expression_n_)');
			  nextPut: (RMDSourceTemplate
					   name: 'mean'
					   description:
						   'Usage: mean(expression1, expression2, ..., expression_n)'
						   , String cr , 'the mean value of the arguments' , String cr
						   , 'Note: one or more arguments must be given.'
					   sourceText:
						   'mean(_expression1_, _expression2_, ..., _expression_n_)');
			  nextPut: (RMDSourceTemplate
					   name: 'gaussian'
					   description:
						   'Usage: gaussian(a, b, c, x)' , String cr
						   , 'the gaussian function' , String cr
						   , 'Note: b is also called as mean and c as sigma.'
					   sourceText: 'gaussian(_a_, _b_, _c_ , _x_)') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> carbonmasses [

	^ Array streamContents: [ :stream |
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'tC (tons-of-carbon)'
					   description: '1 [t] = 1000 [kg]'
					   sourceText: 't');
			  nextPut: (RMDSourceTemplate
					   name: 'kgC (kilo-grams-of-carbon)'
					   description: 'kg of Carbon'
					   sourceText: 'kgC');
			  nextPut: (RMDSourceTemplate
					   name: 'gC (grams-of-carbon)'
					   description: '1000 [gC] = 1 [kgC]'
					   sourceText: 'gC');
			  nextPut: (RMDSourceTemplate
					   name: 'mgC (milli-grams-of-carbon)'
					   description: '10^6 [mgC] = 1 [kgC]'
					   sourceText: 'mgC');
			  nextPut: (RMDSourceTemplate
					   name: 'µgC (micro-grams-of-carbon)'
					   description: '10^9 [µgC] = 1 [kgC]'
					   sourceText: 'µmC');
			  nextPut: (RMDSourceTemplate
					   name: 'ngC (nano-grams-of-carbon)'
					   description: '10^12 [ngC] = 1 [kgC]'
					   sourceText: 'ngC');
			  nextPut: (RMDSourceTemplate
					   name: 'pgC (pico-grams-of-carbon)'
					   description: '10^15 [ngC] = 1 [kgC]'
					   sourceText: 'pgC');
			  nextPut: (RMDSourceTemplate
					   name: 'fgC (femto-grams-of-carbon)'
					   description: '10^18 [ngC] = 1 [kgC]'
					   sourceText: 'fgC') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> energies [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'J (Joule)'
					   description: 'the SI derrived unit for energy'
					   sourceText: 'J');
			  nextPut: (RMDSourceTemplate
					   name: 'cal (calories)'
					   description: '1 [cal] = 4.184 [J]'
					   sourceText: 'cal');
			  nextPut: (RMDSourceTemplate
					   name: 'kcal (kilo-calories)'
					   description: '1 [kcal] = 4184 [J]'
					   sourceText: 'kcal') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> estimations [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'mean lifetime by temperature'
					   description:
						   'Usage: (lambda*power(positive((°C)(t - to)), delta))[day]'
						   , String cr
						   ,
							   'the estimated duration of the stage based on the temperature'
					   sourceText:
						   '(_lambda_*power(positive((°C)(_temperature_ - _base_temperature_)), _delta_))[day]');
			  nextPut: (RMDSourceTemplate
					   name: 'mean clutch size by temperature'
					   description:
						   'Usage: power((t / to)*power(χ, u), θ)' , String cr
						   , 'the estimated the clutch size based on the temperature'
					   sourceText:
						   'power((_temperature_ / _base_temperature_)*power(_qi_, _u_), _theta_)');
			  nextPut: (RMDSourceTemplate
					   name: 'χ for the clutch size estimation'
					   description: 'Usage: positive(tm - t)/(tm - to)' , String cr
						   , 'the estimated χ parameter for the clutch size estimation'
					   sourceText:
						   'positive(_max_temperature_ - _temperature_)/(_max_temperature_ - _base_temperature_)');
			  nextPut: (RMDSourceTemplate
					   name: 'u for the clutch size estimation'
					   description: 'Usage: (tm - to)/to' , String cr
						   , 'the estimated u parameter for the clutch size estimation'
					   sourceText:
						   '(_max_temperature_ - _base_temperature_) / _base_temperature_') ]
]

{ #category : #menu }
TRMDTemplateMenu >> expressionTemplateMenu [

	| menu |
	menu := SpMenuPresenter new.
	menu addGroup: [ :group | 
		{ 
			('Arithmetics...' -> self arithmetics).
			('Simulation...' -> self simulationTimes).
			('Spatial...' -> self spatialExpressions).
			('Unit conversions...' -> self unitConversions).
			('Random distributions...' -> self randomDistributions).
			('Life-cycle estimations...' -> self estimations) } do: [ :assoc | 
			group addItem: [ :item | 
				| submenu |
				item name: assoc key.
				submenu := SpMenuPresenter new.
				assoc value do: [ :sourceTemplate | 
					sourceTemplate addToMenu: submenu for: self ].
				item subMenu: submenu ] ] ].
	^ menu
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> forces [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'N (Newtons)'
					   description: 'the SI derrived unit for force'
					   sourceText: 'N');
			  nextPut: (RMDSourceTemplate
					   name: 'kgf (killo-grams force)'
					   description: '1 [kgf] = 9.8 [N]'
					   sourceText: 'kgf');
			  nextPut: (RMDSourceTemplate
					   name: 'dyn (dynes)'
					   description: '1 [dyn] = 10^-5 [N]'
					   sourceText: 'dyn');
			  nextPut: (RMDSourceTemplate
					   name: 'lbf (pounds force)'
					   description: '1 [lbf] = 4.4482216152605 [N]'
					   sourceText: 'lbf') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> lengths [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'km (kilo-meters)'
					   description: '1 [km] = 1000 [m]'
					   sourceText: 'km');
			  nextPut: (RMDSourceTemplate
					   name: 'm (meters)'
					   description: 'the SI base unit for length'
					   sourceText: 'km');
			  nextPut: (RMDSourceTemplate
					   name: 'cm (centi-meters)'
					   description: '100 [cm] = 1 [m]'
					   sourceText: 'km');
			  nextPut: (RMDSourceTemplate
					   name: 'mm (milli-meters)'
					   description: '1000 [mm] = 1 [m]'
					   sourceText: 'km');
			  nextPut: (RMDSourceTemplate
					   name: 'µm (micro-meters)'
					   description: '10^6 [µm] = 1 [m]'
					   sourceText: 'µm');
			  nextPut: (RMDSourceTemplate
					   name: 'nm (nano-meters)'
					   description: '10^9 [nm] = 1 [m]'
					   sourceText: 'nm');
			  nextPut: (RMDSourceTemplate
					   name: 'mi (miles)'
					   description: '1 [mi] = 1609.344[m]'
					   sourceText: 'mi');
			  nextPut: (RMDSourceTemplate
					   name: 'yd (yards)'
					   description: '1 [yd] = 0.9144[m]'
					   sourceText: 'yd');
			  nextPut: (RMDSourceTemplate
					   name: 'ft (feet)'
					   description: '1 [ft] = 0.3048[m]'
					   sourceText: 'ft');
			  nextPut: (RMDSourceTemplate
					   name: 'in (inches)'
					   description: '1 [in] = 0.0.0254[m]'
					   sourceText: 'in') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> masses [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 't (tons)'
					   description: '1 [t] = 1000 [kg]'
					   sourceText: 't');
			  nextPut: (RMDSourceTemplate
					   name: 'kg (kilo-grams)'
					   description: 'the SI base unit for mass'
					   sourceText: 'kg');
			  nextPut: (RMDSourceTemplate
					   name: 'g (grams)'
					   description: '1000 [g] = 1 [kg]'
					   sourceText: 'g');
			  nextPut: (RMDSourceTemplate
					   name: 'mg (milli-grams)'
					   description: '10^6 [mg] = 1 [kg]'
					   sourceText: 'mg');
			  nextPut: (RMDSourceTemplate
					   name: 'µg (micro-grams)'
					   description: '10^9 [µg] = 1 [kg]'
					   sourceText: 'µm');
			  nextPut: (RMDSourceTemplate
					   name: 'ng (nano-grams)'
					   description: '10^12 [ng] = 1 [kg]'
					   sourceText: 'ng');
			  nextPut: (RMDSourceTemplate
					   name: 'pg (pico-grams)'
					   description: '10^15 [ng] = 1 [kg]'
					   sourceText: 'pg');
			  nextPut: (RMDSourceTemplate
					   name: 'fg (femto-grams)'
					   description: '10^18 [ng] = 1 [kg]'
					   sourceText: 'fg');
			  nextPut: (RMDSourceTemplate
					   name: 'lb (pounds)'
					   description: '1 [lb] = 0.45359237 [kg]'
					   sourceText: 'lb');
			  nextPut: (RMDSourceTemplate
					   name: 'oz (ounce)'
					   description: '1 [oz] = 0.028349523125 [kg]'
					   sourceText: 'oz') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> powers [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'W (Watt)'
					   description: 'the SI derrived unit for power'
					   sourceText: 'W');
			  nextPut: (RMDSourceTemplate
					   name: 'kW (kilo-watt)'
					   description: '1 [kW] = 1000 [W]'
					   sourceText: 'kW');
			  nextPut: (RMDSourceTemplate
					   name: 'MW (mega-watt)'
					   description: '1 [MW] = 10^6 [W]'
					   sourceText: 'MW');
			  nextPut: (RMDSourceTemplate
					   name: 'GW (giga-watt)'
					   description: '1 [GW] = 10^9 [W]'
					   sourceText: 'GW');
			  nextPut: (RMDSourceTemplate
					   name: 'PS'
					   description: '1 [PS] = 735.5 [W]'
					   sourceText: 'PS');
			  nextPut: (RMDSourceTemplate
					   name: 'HP'
					   description: '1 [HP] = 745 [W]'
					   sourceText: 'HP') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> pressures [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'Pa (Pascals)'
					   description: 'the SI derrived unit for pressure'
					   sourceText: 'Pa');
			  nextPut: (RMDSourceTemplate
					   name: 'hPa (hecto-pascals)'
					   description: '1 [hPa] = 10^2 [Pa]'
					   sourceText: 'hPa');
			  nextPut: (RMDSourceTemplate
					   name: 'bar (barr)'
					   description: '1 [bar] = 100000 [Pa]'
					   sourceText: 'bar');
			  nextPut: (RMDSourceTemplate
					   name: 'at (technical atomosphere)'
					   description: '1 [at] = 98066.5 [Pa]'
					   sourceText: 'at');
			  nextPut: (RMDSourceTemplate
					   name: 'atm (standard atomosphere)'
					   description: '1 [atm] = 101325 [Pa]'
					   sourceText: 'atm');
			  nextPut: (RMDSourceTemplate
					   name: 'psi'
					   description: '1 [psi] = 6894.757 [Pa]'
					   sourceText: 'psi') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> probabilities [

	^ Array streamContents: [ :stream | 
		  stream nextPut: (RMDSourceTemplate
				   name: '% (percent)'
				   description: '1 [%] = 0.01 []' , String cr
					   , 'Note: the probability is non-dimensional.'
				   sourceText: '%') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> randomDistributions [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'uniform distribution'
					   description: 'Usage: uniform s to e' , String cr
						   ,
							   'a directive to generate a random number in the uniform distribution between x and y'
						   , String cr , 'Note: The units of s and e must agree.'
					   sourceText: 'uniform _s_ to _e_');
			  nextPut: (RMDSourceTemplate
					   name: 'uniform integer distribution'
					   description: 'Usage: uniform_integer s to e' , String cr
						   ,
							   'a directive to generate a random integer in the uniform distribution between x and y'
						   , String cr , 'Note: The units of s and e must agree.'
					   sourceText: 'uniform_integer _s_ to _e_');
			  nextPut: (RMDSourceTemplate
					   name: 'normal distribution'
					   description: 'Usage: normal m sigma σ' , String cr
						   ,
							   'a directive to generate a random number in the normal distribution with mean=m, sigma=σ'
						   , String cr , 'Note: The units of m and σ must agree.'
					   sourceText: 'normal _mean_ sigma _sigma');
			  nextPut: (RMDSourceTemplate
					   name: 'gamma distribution with rate'
					   description: 'Usage: gamma α rate β' , String cr
						   ,
							   'a directive to generate a random number in the gamma distribution with shape=α, rate=β'
						   , String cr , 'Note: α and β must be positive and have no unit.'
					   sourceText: 'gamma _shape_ rate _rate_');
			  nextPut: (RMDSourceTemplate
					   name: 'gamma distribution with scale'
					   description: 'Usage: gamma k scale θ' , String cr
						   ,
							   'a directive to generate a random number in the gamma distribution with shape=k, scale=θ'
						   , String cr , 'Note: k and θ must be positive and have no unit.'
					   sourceText: 'gamma _shape_ scale _scale_*_mean_');
			  nextPut: (RMDSourceTemplate
					   name: 'gamma distribution with mean'
					   description: 'Usage: gamma α mean m' , String cr
						   ,
							   'a directive to generate a random number in the gamma distribution with shape=α, rate=1/α*mean'
						   , String cr , 'Note: α and m must be positive and have no unit.'
					   sourceText: 'gamma _shape_ mean _mean_');
			  nextPut: (RMDSourceTemplate
					   name: 'log-logistic distribution'
					   description: 'Usage: loglogistic α shape β' , String cr
						   ,
							   'a directive to generate a random number in the log-logistic distribution with scale=α, shape=β'
						   , String cr , 'Note: α and β must have no unit.'
					   sourceText: 'loglogistic _scale_ shape _shape_') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> roundings [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'round'
					   description: 'Usage: round(expression)' , String cr
						   , 'the expression rounded to integer'
					   sourceText: 'round(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'floor'
					   description: 'Usage: floor(expression)' , String cr
						   , 'the expression rounded down to integer'
					   sourceText: 'floor(_expression_)');
			  nextPut: (RMDSourceTemplate
					   name: 'ceiling'
					   description: 'Usage: ceiling(expression)' , String cr
						   , 'the expression rounded up to integer'
					   sourceText: 'ceiling(_expression_)') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> simulationTimes [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'current simulation time'
					   description:
						   'Usage: time' , String cr
						   , 'the simulation time since the beginning'
					   sourceText: 'time');
			  nextPut: (RMDSourceTemplate
					   name: 'simulation time step'
					   description:
						   'Usage: Δtime' , String cr , 'the simulation time sterp'
					   sourceText: 'Δtime') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> spatialExpressions [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'direction of an animat'
					   description: 'Usage: direction animat' , String cr
						   , 'the direction to the given animat ' , String cr
						   , 'Note: the direction is absolute angle' , String cr
						   , 'where the east is 0 [degree], the north is 90 [degree],'
						   , String cr
						   , 'the west is 180 [degree] and the south is 270 [degree]'
					   sourceText: 'direction _animat_');
			  nextPut: (RMDSourceTemplate
					   name: 'distance to an animat'
					   description: 'Usage: distance animat' , String cr
						   , 'the distance to the given animat '
					   sourceText: 'distance _animat_');
			  nextPut: (RMDSourceTemplate
					   name: 'direction of the spatial gradient'
					   description:
						   'Usage: direction neighbor''s attribute' , String cr
						   ,
							   'the direction to the direction of the gradient of the given Patch''s attribute'
						   , String cr , 'Note: the direction is absolute angle'
						   , String cr
						   , 'where the east is 0 [degree], the north is 90 [degree],'
						   , String cr
						   , 'the west is 180 [degree] and the south is 270 [degree]'
					   sourceText: 'direction neighbor''s _patch_attribute_') ]
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> temperatures [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'K (Kelvin)'
					   description: 'the SI base unit for temperature'
					   sourceText: 'K');
			  nextPut: (RMDSourceTemplate
					   name: '°C (Celsius, DegreeC)'
					   description: '1 [℃] = 273.15 [K]' , String cr
						   , 'Note: °C is not automatically converted into K'
					   sourceText: '°C');
			  nextPut: (RMDSourceTemplate
					   name: '°F (Fahrenheit, DegreeF)'
					   description: 'Note: °F is not automatically converted into K'
					   sourceText: '°F') ]
]

{ #category : #accessing }
TRMDTemplateMenu >> templateDirectory [

	^ (FileLocator documents / 'ReMobidyc' / 'templates')
		  ensureCreateDirectory
]

{ #category : #menu }
TRMDTemplateMenu >> templateMenu [

	| menu |
	menu := SpMenuPresenter new
		        addItem: [ :item | 
			        item
				        name: 'Expressions...';
				        subMenu: self expressionTemplateMenu ];
		        addItem: [ :item | 
			        item
				        name: 'Units...';
				        subMenu: self unitTemplateMenu ];
		        addItem: [ :item | 
			        item
				        name: 'User-defined...';
				        subMenu: self userDefinedTemplateMenu ];
		        yourself.
	^ menu
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> times [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'year'
					   description: ' 1[year] = 31557600 [s]'
					   sourceText: 't');
			  nextPut: (RMDSourceTemplate
					   name: 'month31'
					   description: 'month of 31 days' , String cr
						   , '1 [month31] = 31 [day] = 2678400 [s]'
					   sourceText: 'month31');
			  nextPut: (RMDSourceTemplate
					   name: 'month'
					   description: '1 [month] = 30 [day] = 2592000 [s]'
					   sourceText: 'month');
			  nextPut: (RMDSourceTemplate
					   name: 'week'
					   description: '1 [week] = 7 [day] = 604800 [s]'
					   sourceText: 'week');
			  nextPut: (RMDSourceTemplate
					   name: 'day'
					   description: '1 [day] = 24 [hour] = 86400 [s]'
					   sourceText: 'day');
			  nextPut: (RMDSourceTemplate
					   name: 'h (hours)'
					   description: '1 [h] = 60 [min] = 3600 [s]'
					   sourceText: 'h');
			  nextPut: (RMDSourceTemplate
					   name: 'min (minutes)'
					   description: '1 [min] = 60 [s]'
					   sourceText: 'min');
			  nextPut: (RMDSourceTemplate
					   name: 's (seconds)'
					   description: 'the SI base unit for time'
					   sourceText: 's');
			  nextPut: (RMDSourceTemplate
					   name: 'ms (milli-seconds)'
					   description: '1000 [ms] = 1 [s]'
					   sourceText: 'ms');
			  nextPut: (RMDSourceTemplate
					   name: 'μs (micro-seconds)'
					   description: '10^6 [μs] = 1 [s]'
					   sourceText: 'μs') ]
]

{ #category : #'templates-expressions' }
TRMDTemplateMenu >> unitConversions [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'attach a unit to a non-dimensional number'
					   description: 'Usage: expression [unit]' , String cr
						   , 'the quantity with a measuring unit' , String cr
						   , 'Note: the expression must be non-dimensional.'
					   sourceText: '_expression_ [_unit_]');
			  nextPut: (RMDSourceTemplate
					   name: 'detach a unit to make a non-dimensional number'
					   description: 'Usage: (unit) expression' , String cr
						   ,
							   'the non-dimensional number from the given expression read in the given measuring unit'
						   , String cr
						   ,
							   'Note: the expression must have a unit that has the same dimension as the given unit.'
					   sourceText: '(_unit_) _expression_') ]
]

{ #category : #menu }
TRMDTemplateMenu >> unitTemplateMenu [

	| menu |
	menu := SpMenuPresenter new.
	menu addGroup: [ :group |
		{
			('Length...' -> self lengths).
			('Mass...' -> self masses).
			('Mass of Carbon...' -> self carbonmasses).
			('Time...' -> self times).
			('Temperature...' -> self temperatures).
			('Angle...' -> self angles).
			('Probability...' -> self probabilities).
			('Amount...' -> self amounts).
			('Area...' -> self areas).
			('Volume...' -> self volumes).
			('Force...' -> self forces).
			('Pressure...' -> self pressures).
			('Energy...' -> self energies).
			('Power' -> self powers) } do: [ :assoc |
			group addItem: [ :item |
				| submenu |
				item name: assoc key.
				submenu := SpMenuPresenter new.
				assoc value do: [ :sourceTemplate |
					sourceTemplate addToMenu: submenu for: self ].
				item subMenu: submenu ] ] ].
	^ menu
]

{ #category : #menu }
TRMDTemplateMenu >> userDefinedTemplateMenu [

	| menu |
	menu := SpMenuPresenter new.
	menu addGroup: [ :group | 
		(self templateDirectory filesMatching: '*.json') do: [ :fileRef | 
			| submenu |
			group addItem: [ :item | 
				item name: (fileRef basenameWithoutExtension: 'json').
				submenu := SpMenuPresenter new.
				fileRef readStreamDo: [ :stream | 
					([ STONJSON fromStream: stream ]
						 on: Error
						 do: [ :ex | #(  ) ]) do: [ :dict | 
						| sourceTemplate |
						sourceTemplate := RMDSourceTemplate fromJsonObject: dict.
						sourceTemplate addToMenu: submenu for: self ] ].
				item subMenu: submenu ] ] ].

	^ menu
]

{ #category : #'templates-units' }
TRMDTemplateMenu >> volumes [

	^ Array streamContents: [ :stream | 
		  stream
			  nextPut: (RMDSourceTemplate
					   name: 'm^3 (cubic meters)'
					   description: 'the SI derrived unit for volume'
					   sourceText: 'm^3');
			  nextPut: (RMDSourceTemplate
					   name: 'mm^3 (cubic milli-meters)'
					   description: '10^9 [mm^3] = 1 [m^3]'
					   sourceText: 'mm^3');
			  nextPut: (RMDSourceTemplate
					   name: 'L (litres)'
					   description: '1 [L] = 10^-3 [m^3]'
					   sourceText: 'L');
			  nextPut: (RMDSourceTemplate
					   name: 'dL (deci-litres)'
					   description: '1 [dL] = 10^-4 [m^3]'
					   sourceText: 'dL');
			  nextPut: (RMDSourceTemplate
					   name: 'mL (milli-litres)'
					   description: '1 [mL] = 10^-6 [m^3]'
					   sourceText: 'mL');
			  nextPut: (RMDSourceTemplate
					   name: 'μL (micro-litres)'
					   description: '1 [μL] = 10^-9 [m^3]'
					   sourceText: 'μL') ]
]
