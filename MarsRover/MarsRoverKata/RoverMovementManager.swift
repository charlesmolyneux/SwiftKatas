struct RoverMovementManager {
  let plateuBoundaryCoordinates: Coordinates
  
  public init(plateuBoundaryCoordinates: Coordinates) {
    self.plateuBoundaryCoordinates = plateuBoundaryCoordinates
  }
  
  func move(given rover: Rover, input: [String]) -> Rover {
    var coordinates = rover.position.coordinates
    var orientation =  rover.position.orientation
        
    input.forEach { command in
      switch MoveInputCommand(command) {
      case .move:
        coordinates = move(in: orientation, current: coordinates)
      case .turn(let turnDirection):
        orientation = OrientationHelper().reorient(with: turnDirection, currentOrientation: orientation)
      case .invalid:
        return
      }
    }
    
    return Rover(position: RoverPosition(coordinates: coordinates, orientation: orientation))
  }
  
  private func move(in orientation: Orientation, current coordinates: Coordinates) -> Coordinates {
    var x: Int = coordinates.x
    var y: Int = coordinates.y
    
    switch orientation {
      case .north: y += 1
      case .east: x += 1
      case .south: y -= 1
      case .west: x -= 1
      case .invalid: return coordinates
    }
     
    let newPositionIsWithinBounds = (plateuBoundaryCoordinates.x >= x && plateuBoundaryCoordinates.y >= y) && (x >= 0 && y >= 0)
    guard newPositionIsWithinBounds else { return coordinates }
    
    return Coordinates(x: x, y: y)
  }
}
