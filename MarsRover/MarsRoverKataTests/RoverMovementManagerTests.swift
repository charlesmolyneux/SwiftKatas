import XCTest
@testable import MarsRoverKata

class RoverMovementManagerTests: XCTestCase {
  var movementManager: RoverMovementManager!
  
  override func setUp() {
    super.setUp()
    movementManager = RoverMovementManager(plateuBoundaryCoordinates: .init(x: 5, y: 5))
  }
  
  func test_givenMoveInstruction_facingNorth_incrementsY() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 0, y: 0), orientation: .north)
    assert(given: roverPosition, instructions: ["M"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 0, y: 1), orientation: .north))
  }
  
  func test_givenMoveInstruction_facingEast_incrementsX() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 0, y: 0), orientation: .east)
    assert(given: roverPosition, instructions: ["M"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 1, y: 0), orientation: .east))
  }
  
  func test_givenMoveInstruction_facingWest_decrementsX() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 3, y: 0), orientation: .west)
    assert(given: roverPosition, instructions: ["M"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 2, y: 0), orientation: .west))
  }
  
  func test_givenLeftInstruction_facingEast_turnsRoverNorth() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 0, y: 0), orientation: .east)
    assert(given: roverPosition, instructions: ["L"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 0, y: 0), orientation: .north))
  }
  
  func test_givenNewInputCommand_wouldMoveRoverOutsideOfBoundary_doesNotUpdatePosition() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 5, y: 5), orientation: .north)
    assert(given: roverPosition, instructions: ["M"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 5, y: 5), orientation: .north))
  }
  
  func test_givenBasicChainOfMovements_roverMovesForward() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 1, y: 3), orientation: .north)
    assert(given: roverPosition, instructions: ["M", "M", "M", "L"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 1, y: 5), orientation: .west))
  }
  
  func test_givenKeepMovingSouth_cannotGoBelowZeroYCoordinate() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 0, y: 5), orientation: .south)
    assert(given: roverPosition, instructions: ["M", "M", "M", "M", "M", "M", "M", "M", "M"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 0, y: 0), orientation: .south))
  }
  
  func test_givenInvalidMoveCommand_IgnoresCommand() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 1, y: 2), orientation: .north)
    assert(given: roverPosition, instructions: ["M", "M", "B", "R"], expectedNewPosition: RoverPosition(coordinates: Coordinates(x: 1, y: 4), orientation: .east))
  }
  
  func test_givenNoInstructions_roverDoesNotMove() {
    let roverPosition = RoverPosition(coordinates: Coordinates(x: 1, y: 2), orientation: .north)
    assert(given: roverPosition, instructions: [], expectedNewPosition: roverPosition)
  }
  
  func assert(given roverPosition: RoverPosition, instructions: [String], expectedNewPosition: RoverPosition) {
    let rover = Rover(position: roverPosition)
        
    let updatedRover = movementManager.move(given: rover, input: instructions)

    XCTAssertEqual(Rover(position: expectedNewPosition), updatedRover)
  }
}

extension Rover: Equatable {
  static public func == (lhs: Rover, rhs: Rover) -> Bool {
    return rhs.moveInstructions == lhs.moveInstructions && rhs.position == lhs.position
  }
}
