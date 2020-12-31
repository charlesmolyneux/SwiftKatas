public struct OrientationHelper {
  public func reorient(with command: MoveInputCommand.TurnDirection, currentOrientation: Orientation) -> Orientation {
    switch (currentOrientation, command) {
    case (.north, .left): return .west
    case (.north, .right): return .east
      
    case (.south, .left): return .east
    case (.south, .right): return .west
      
    case (.east, .left): return .north
    case (.east, .right): return .south
      
    case (.west, .left): return .south
    case (.west, .right): return .north
    case (.invalid, _): return currentOrientation
    }
  }
}
