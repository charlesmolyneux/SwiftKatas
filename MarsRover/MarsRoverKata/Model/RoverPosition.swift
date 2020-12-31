public struct RoverPosition {
  public let coordinates: Coordinates
  public let orientation: Orientation
}

public enum Orientation {
  case north, east, south, west, invalid
  
  public init(_ input: String) {
    switch input.uppercased() {
    case "N": self = .north
    case "S": self = .south
    case "W": self = .west
    case "E": self = .east
    default: self = .invalid
    }
  }
}
