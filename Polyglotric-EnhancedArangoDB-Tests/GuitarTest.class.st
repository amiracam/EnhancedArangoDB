"
A GuitarTest is a test class for testing the behavior of Guitar
"
Class {
	#name : #GuitarTest,
	#superclass : #TestCase,
	#instVars : [
		'arango'
	],
	#category : #'Polyglotric-EnhancedArangoDB-Tests'
}

{ #category : #'test support' }
GuitarTest >> baseUri [ 
	^ 'http://localhost:8529/'
]

{ #category : #'test support' }
GuitarTest >> createTestCollection [
	self halt. 
	arango database: 'music_gear'.
	arango createCollectionIfDoesntExist: 'guitars'
]

{ #category : #'test support' }
GuitarTest >> createTestDatabase [
	arango createDatabaseIfDoesntExist:  'music_gear'
]

{ #category : #running }
GuitarTest >> setUp [
	super setUp.
	
	arango := ArangoDBClient new baseUri: self baseUri.
	[self createTestDatabase. 
	self createTestCollection] 
		on: ArangoDuplicateNamed 
		do: [:ex | ex description  traceCr  ].
	
]

{ #category : #tests }
GuitarTest >> testGuitarAccessors [

	| guitar varNames |
	guitar := Guitar new.
	varNames := guitar class instVarNames.
	self assert: (varNames includesAll: #(_id _rev _key))
]

{ #category : #tests }
GuitarTest >> testPersistDocument [

		
	| guitar resp |
	guitar := Guitar new.
	
	guitar 
		model: 'MultiacJazz';
		brand: 'Godin';
		yearBuilt: '2010';
		pickupType: 'Humbuckers';
		neckType: 'Ebony'.
		
	arango database:'music_gear'.
	arango collection: 'guitars'.
	resp := arango createDocument: guitar asDictionary.
	
	Transcript show: resp asString.
		
	
]
