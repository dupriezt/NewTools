Class {
	#name : #DebugCommand,
	#superclass : #CmCommand,
	#instVars : [
		'dbg'
	],
	#classVars : [
		'AnonymousCommands'
	],
	#category : #'Debugger-Commands'
}

{ #category : #'as yet unclassified' }
DebugCommand class >> AnonymousCommands [
	AnonymousCommands ifNil: [ AnonymousCommands := OrderedCollection new ].
	^ AnonymousCommands
]

{ #category : #'instance creation' }
DebugCommand class >> addAnonymousCommand: aCommand [
	self AnonymousCommands add: aCommand
]

{ #category : #'instance creation' }
DebugCommand class >> codeContextMenuCommandsForDebugger: debugger [

<<<<<<< HEAD
{ #category : #accessing }
DebugCommand class >> debugCommandClassesForPragma: aSymbol [
	| allClasses commandsClasses |
	allClasses := OrderedCollection withAll: self allSubclasses.
	allClasses addAll: self AnonymousCommands.
	commandsClasses := OrderedCollection new.
	(allClasses reject: [ :sc | sc hasAbstractMethods ])
		do: [ :commandClass | 
			commandsClasses addAll: (Pragma
				allNamed: aSymbol
				from: commandClass class
				to: commandClass class) ].
	
	^ ((aSymbol last = $:)
		ifTrue: [ commandsClasses sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ] ]
		ifFalse: [ commandsClasses ])
		collect: [ :pragma | pragma methodClass soleInstance ]
=======
	^ self
		instantiateCommandsFromPragma: #CodeContextMenuDebugCommand
		for: debugger
>>>>>>> upstream/master
]

{ #category : #initialization }
DebugCommand class >> defaultIconName [
	^ self subclassResponsibility
]

{ #category : #initialization }
DebugCommand class >> defaultShortcut [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
DebugCommand class >> forSpecContext: anObject [
	^ (self
		forSpecWithIconNamed: self defaultIconName
		shortcutKey: self defaultShortcut)
		context: anObject;
		yourself
]

{ #category : #'instance creation' }
<<<<<<< HEAD
DebugCommand class >> instantiateCommands: commandClasses forDebugger: debugger [
	^ commandClasses
		collect: [ :commandClass | commandClass forSpecContext: debugger ]
		thenSelect: [ :debugCommand | debugCommand decoratedCommand appliesToDebugger: debugger ]
]

{ #category : #'instance creation' }
DebugCommand class >> newAnonymousActionLabeled: title icon: icon executeScript: sourceCode [

	|command|
	command := self newAnonymousSubclass.
	command compile: 'execute 	
		dbg deactivateAutoRefreshOfAttachedGraphicalDebugger.
		self executeSindarinCommand.
		dbg activateAutoRefreshOfAttachedGraphicalDebugger.'.
	command compile: 'executeSindarinCommand ', sourceCode.
	
	command class compile: 'defaultCommandName
	<toolbarDebugCommand: 9999>
	^', title printString.
	command class compile: 'defaultIconName
	^#', icon.
	command class compile: 'defaultShortcut
	^ nil'.
	self addAnonymousCommand: command.
	^command
]

{ #category : #'instance creation' }
=======
>>>>>>> upstream/master
DebugCommand class >> preDebugCommandsForDebugger: debugger [
	
	^ self
		instantiateCommandsFromPragma: #PreDebugCommand
		for: debugger
]

{ #category : #'instance creation' }
DebugCommand class >> removeAllAnonymousCommands [
	AnonymousCommands := nil
]

{ #category : #'instance creation' }
DebugCommand class >> stackContextMenuCommandsForDebugger: debugger [
	
	^ self
		instantiateCommandsFromPragma: #StackContextMenuDebugCommand
		for: debugger
]

{ #category : #'instance creation' }
DebugCommand class >> toolbarCommandsForDebugger: debugger [

	^ self
		instantiateCommandsFromPragma: #toolbarDebugCommand:
		for: debugger
]

{ #category : #testing }
DebugCommand >> appliesTo: aDebugger [

	^ self appliesToDebugger: aDebugger
]

{ #category : #testing }
DebugCommand >> appliesToDebugger: aDebugger [

	^ true
]

{ #category : #initialization }
DebugCommand >> context: aContext [
	super context: aContext.
	dbg := self debugger sindarinDebugger
]

{ #category : #accessing }
DebugCommand >> currentContext [

	^ self debugger currentContext
]

{ #category : #accessing }
DebugCommand >> debugger [
	^self context
]

{ #category : #initialization }
DebugCommand >> initialize [

	super initialize.
<<<<<<< HEAD

=======
	self description: (String streamContents: [ :stream | 
		stream 
			<< self class defaultName
			<< ': '
			<< self class defaultDescription ])
]

{ #category : #hooks }
DebugCommand >> interruptedContext [
	^ self debugger interruptedContext
>>>>>>> upstream/master
]

{ #category : #accessing }
DebugCommand >> session [
	^self debugger session
]
