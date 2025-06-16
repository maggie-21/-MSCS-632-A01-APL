"Define Ride class"
Object subclass: Ride [
    | rideID pickup dropoff distance |

    Ride class >> newWith: id pickup: p dropoff: d distance: dist [
        ^self new initializeWith: id pickup: p dropoff: d distance: dist
    ]

    initializeWith: id pickup: p dropoff: d distance: dist [
        rideID := id.
        pickup := p.
        dropoff := d.
        distance := dist.
    ]

    fare [
        "abstract method"
        ^0.
    ]

    rideDetails [
        ^'Ride ID: ', rideID printString, 
          ', From: ', pickup, 
          ', To: ', dropoff, 
          ', Distance: ', distance printString
    ]
]

"Define StandardRide"
Ride subclass: StandardRide [
    fare [
        ^distance * 1.5
    ]
]

"Define PremiumRide"
Ride subclass: PremiumRide [
    fare [
        ^distance * 3
    ]
]

"Define Driver class"
Object subclass: Driver [
    | name rides |

    Driver class >> newWith: n [
        ^self new initializeWith: n
    ]

    initializeWith: n [
        name := n.
        rides := OrderedCollection new.
    ]

    addRide: r [
        rides add: r.
    ]

    info [
        | details |
        details := 'Driver: ', name, ', Rides:'.
        rides do: [ :r | 
            details := details, '\n', r rideDetails, ', Fare: $', r fare printString
        ].
        ^details
    ]
]

"Define Rider class"
Object subclass: Rider [
    | name requests |

    Rider class >> newWith: n [
        ^self new initializeWith: n
    ]

    initializeWith: n [
        name := n.
        requests := OrderedCollection new.
    ]

    requestRide: r [
        requests add: r.
    ]

    viewRides [
        | info |
        info := 'Rider: ', name, ', Requested Rides:'.
        requests do: [ :r |
            info := info, '\n', r rideDetails, ', Fare: $', r fare printString
        ].
        ^info
    ]
]

"=== Main Program ==="
| r1 r2 driver rider |

r1 := StandardRide newWith: 101 pickup: 'A' dropoff: 'B' distance: 5.
r2 := PremiumRide newWith: 102 pickup: 'C' dropoff: 'D' distance: 8.

driver := Driver newWith: 'Alex'.
driver addRide: r1.
driver addRide: r2.

rider := Rider newWith: 'Sara'.
rider requestRide: r1.
rider requestRide: r2.

Transcript show: '--- Driver Info ---\n'.
Transcript show: driver info; nl.
Transcript show: '\n--- Rider Info ---\n'.
Transcript show: rider viewRides; nl.