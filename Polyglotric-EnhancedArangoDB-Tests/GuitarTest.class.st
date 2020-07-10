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
GuitarTest >> testFindByID [
		
	| response arangoResponse resp guitar1 |
	
	response := arango findById: 'guitars/Godin_MultiacJazz2020'.
	
	arangoResponse := NeoJSONReader fromString: (NeoJSONWriter toString: response)  as: ArangoResponse .	
	"empty collection , empty result, but parsing passes"	
	self flag: 'replication specs need to account for 1:n relationships'.
 	guitar1 := Guitar newFromData: arangoResponse result first.
	
	self assert: guitar1 brand equals: 'Godin'
		
	
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
		_key: 'Godin_MultiacJazz2020';
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

{ #category : #tests }
GuitarTest >> testStoreStringForBlock [
		
	
	[  ] storeString.

	self assert: true
	
]
