Class {
	#name : #DebugSessionStorage,
	#superclass : #Object,
	#instVars : [
		'storage',
		'storageLimitForDebugSessionsNotKeptAlive',
		'subscribersOnStorageLimitUpdate',
		'subscribersOnStorageUpdate'
	],
	#classVars : [
		'singleton'
	],
	#category : #DebuggerSelector
}

{ #category : #singleton }
DebugSessionStorage class >> singleton [
	singleton ifNil: [ singleton := self new ].
	^ singleton
]

{ #category : #'publish events' }
DebugSessionStorage >> addSubscriberOnStorageLimitUpdate: anObject [
	self subscribersOnStorageLimitUpdate add: anObject
]

{ #category : #'publish events' }
DebugSessionStorage >> addSubscriberOnStorageUpdate: anObject [
	self subscribersOnStorageUpdate add: anObject
]

{ #category : #private }
DebugSessionStorage >> clear [
	"This method should only be used for development purposes. It does not call #terminate on the stored debug sessions, and therefore does not let the debugged process be removed from the system (they will linger on)"

	<script>
	self storage removeAll.
	self notifySubscribersOfAStorageUpdate
]

{ #category : #storage }
DebugSessionStorage >> enforceStorageLimit [
	"Terminate stored debug sessions until the limit (defined in the storageLimitForDebugSessionNotKeptAlive variable) is satisfied.
	Oldest debug sessions are terminated first.
	Debug sessions that are being kept alive (see DebugSession>>#keepAlive:) are ignored and remain stored regardless. They do not count towards the storage limit."

	| debugSessionStorageUnits |
	"Smalltalk garbageCollect.""This is to make sure that closed debuggers are garbage collected so that they stop keeping alive their debug sessions. Doing a gabage collect here is maybe a bit heavy-handed. There maybe is a better solution"
	debugSessionStorageUnits := self storage reject: [ 
		                            :aDebugSessionStorageUnit | 
		                            aDebugSessionStorageUnit debugSession
			                            shouldBeKeptAlive ]. "Select all the stored debug sessions that are not being kept alive"
	debugSessionStorageUnits := debugSessionStorageUnits sort: [ :el1 
		                            :el2 | 
		                            el1 timeOfCreation <= el2 timeOfCreation ]. "Sort the debug sessions from oldest to newest"
	1
		to: debugSessionStorageUnits size
			- self storageLimitForDebugSessionsNotKeptAlive
		do: [ :i | 
			self terminate_NoNotification: (debugSessionStorageUnits at: i) ].
	self notifySubscribersOfAStorageUpdate
]

{ #category : #'publish events' }
DebugSessionStorage >> notifySubscribersOfAStorageLimitUpdate [
	self subscribersOnStorageLimitUpdate do: [ :subscriber_ | 
		subscriber_ ifNotNil: [ :subscriber | 
			subscriber onDebugSessionStorageLimitUpdate ] ]
]

{ #category : #'publish events' }
DebugSessionStorage >> notifySubscribersOfAStorageUpdate [
	self subscribersOnStorageUpdate do: [ :subscriber_ | 
		subscriber_ ifNotNil: [ :subscriber | 
			subscriber onDebugSessionStorageUpdate ] ]
]

{ #category : #'react to events' }
DebugSessionStorage >> onDebugSession: aDebugSession gettingKeptAliveBy: anObject [
	self notifySubscribersOfAStorageUpdate
]

{ #category : #'react to events' }
DebugSessionStorage >> onDebugSession: aDebugSession stoppingGettingKeptAliveBy: anObject [
	self notifySubscribersOfAStorageUpdate.
	aDebugSession shouldBeKeptAlive ifFalse: [ "If @aDebugSession is no longer kept alive as a result, maybe we are now breaking the storage limit rule and need to enforce it again" 
		self enforceStorageLimit ]
]

{ #category : #'publish events' }
DebugSessionStorage >> removeSubscriberOnStorageLimitUpdate: anObject [
	self subscribersOnStorageLimitUpdate
		remove: anObject
		ifAbsent: [ "It's a weak collection, its elements can be nilled by the garbage collector at any time if they are not referenced elsewhere, so it can happen not to find the object to remove because it has already been nilled"
			 ]
]

{ #category : #'publish events' }
DebugSessionStorage >> removeSubscriberOnStorageUpdate: anObject [
	self subscribersOnStorageUpdate
		remove: anObject
		ifAbsent: [ "It's a weak collection, its elements can be nilled by the garbage collector at any time if they are not referenced elsewhere, so it can happen not to find the object to remove because it has already been nilled"
			 ]
]

{ #category : #accessing }
DebugSessionStorage >> storage [
	storage ifNil: [ storage := OrderedCollection new ].
	^ storage
]

{ #category : #accessing }
DebugSessionStorage >> storageLimitForDebugSessionsNotKeptAlive [
	storageLimitForDebugSessionsNotKeptAlive ifNil: [ 
		storageLimitForDebugSessionsNotKeptAlive := 5 ].
	^ storageLimitForDebugSessionsNotKeptAlive
]

{ #category : #accessing }
DebugSessionStorage >> storageLimitForDebugSessionsNotKeptAlive: anInteger [
	anInteger isInteger not | anInteger <= 0 ifTrue: [ 
		InvalidValueForStorageLimit signal ].
	storageLimitForDebugSessionsNotKeptAlive := anInteger.
	self notifySubscribersOfAStorageLimitUpdate.
	self enforceStorageLimit
]

{ #category : #storage }
DebugSessionStorage >> storeDebugSession: aDebugSession [
	| storageUnit |
	storageUnit := DebugSessionStorageUnit newFrom: aDebugSession.
	self storage add: storageUnit.
	aDebugSession addSubscriberToKeepAliveEvents: self.
	self notifySubscribersOfAStorageUpdate.
	self enforceStorageLimit.
	^ storageUnit
]

{ #category : #accessing }
DebugSessionStorage >> subscribersOnStorageLimitUpdate [
	subscribersOnStorageLimitUpdate ifNil: [ 
		subscribersOnStorageLimitUpdate := WeakOrderedCollection new ].
	^ subscribersOnStorageLimitUpdate
]

{ #category : #accessing }
DebugSessionStorage >> subscribersOnStorageUpdate [
	subscribersOnStorageUpdate ifNil: [ 
		subscribersOnStorageUpdate := WeakOrderedCollection new ].
	^ subscribersOnStorageUpdate
]

{ #category : #termination }
DebugSessionStorage >> terminate: aDebugSessionStorageUnit [
	"See comment of method #_NoNotification:"

	self terminate_NoNotification: aDebugSessionStorageUnit.
	self notifySubscribersOfAStorageUpdate
]

{ #category : #termination }
DebugSessionStorage >> terminateAll [
	<script>
	self storage copy do: [ :aDebugSessionStorageUnit | 
		self terminate: aDebugSessionStorageUnit ]
]

{ #category : #termination }
DebugSessionStorage >> terminate_NoNotification: aDebugSessionStorageUnit [
	"Terminating the debug session in addition to removing it from the storage is necessary to ensure the debugged process is destroyed and does not linger in the image"

	self storage remove: aDebugSessionStorageUnit.
	aDebugSessionStorageUnit debugSession terminate
]