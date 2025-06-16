"Ride superclass"
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Ride >> initialize
    super initialize.
    rideID := ''.
    pickupLocation := ''.
    dropoffLocation := ''.
    distance := 0.

Ride >> rideID: anID
    rideID := anID.

Ride >> pickupLocation: aLocation
    pickupLocation := aLocation.

Ride >> dropoffLocation: aLocation
    dropoffLocation := aLocation.

Ride >> distance: aDistance
    distance := aDistance.

Ride >> calculateFare
    ^ distance * 1.0.

Ride >> rideDetails
    ^ 'Ride ', rideID, ': ',
      pickupLocation, ' -> ', dropoffLocation,
      ', Distance: ', distance printString,
      ', Fare: $', (self calculateFare) printString.

"StandardRide subclass"
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

StandardRide >> calculateFare
    ^ distance * 1.5.

"PremiumRide subclass"
Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

PremiumRide >> calculateFare
    ^ distance * 3.0.

"Driver class"
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Driver >> initialize
    super initialize.
    assignedRides := OrderedCollection new.

Driver >> driverID: anID name: aName rating: aRating
    self initialize.
    driverID := anID.
    name := aName.
    rating := aRating.

Driver >> addRide: aRide
    assignedRides add: aRide.

Driver >> getDriverInfo
    ^ String streamContents: [:s |
        s nextPutAll: 'Driver ', driverID, ': ', name, ' (Rating: ', rating printString, ')'; cr.
        s nextPutAll: 'Rides:'; cr.
        assignedRides do: [:r |
            s nextPutAll: r rideDetails; cr].
    ].

"Rider class"
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Rider >> initialize
    super initialize.
    requestedRides := OrderedCollection new.

Rider >> riderID: anID name: aName
    self initialize.
    riderID := anID.
    name := aName.

Rider >> requestRide: aRide
    requestedRides add: aRide.

Rider >> viewRides
    ^ String streamContents: [:s |
        s nextPutAll: 'Rider ', riderID, ': ', name; cr.
        s nextPutAll: 'Requested Rides:'; cr.
        requestedRides do: [:r |
            s nextPutAll: r rideDetails; cr].
    ].

"Demonstration in a workspace"
| s1 p1 rides driver rider |
s1 := StandardRide new.
s1 rideID: 'R1'.
s1 pickupLocation: 'A'.
s1 dropoffLocation: 'B'.
s1 distance: 10.

p1 := PremiumRide new.
p1 rideID: 'P1'.
p1 pickupLocation: 'C'.
p1 dropoffLocation: 'D'.
p1 distance: 5.

rides := OrderedCollection with: s1 with: p1.

driver := Driver new.
driver driverID: 'D1' name: 'Alice' rating: 4.9.

rider := Rider new.
rider riderID: 'Rdr1' name: 'Bob'.

rides do: [:r |
    driver addRide: r.
    rider requestRide: r.
].

Transcript show: driver getDriverInfo; cr.
Transcript show: rider viewRides; cr.
