public class RoverCommand {
  private(set) var rovers: [Rover] = []
  
  public func parse(_ input: String) throws {
    guard !input.isEmpty else { throw RoverCommandError.invalidInput }
    
    let instructions = input.split(separator: "\n")
    
    let plateuCoordinates = try parsePlateuCoordinates(instructions)
    
    let roverInstructions = instructions.dropFirst().compactMap { String($0) }
    try createRovers(from: roverInstructions)
    
    let roverMovementManager = RoverMovementManager(plateuBoundaryCoordinates: plateuCoordinates)
    
    rovers.enumerated().forEach { index, rover in
      rovers[index] = roverMovementManager.move(given: rover, input: rover.moveInstructions)
    }
  }
  
  private func parsePlateuCoordinates(_ input: [String.SubSequence]) throws -> Coordinates {
    let plateuInputLine = input.first?.split(separator: " ")

    guard let plateuInstructions = plateuInputLine,
          let plateuMaxXString = plateuInstructions.first,
          let plateuMaxYString = plateuInstructions.last,
          let plateuMaxX = Int(plateuMaxXString),
          let plateuMaxY = Int(plateuMaxYString) else {
      throw RoverCommandError.invalidPlateuCoordinates
    }
    
    return Coordinates(x: plateuMaxX, y: plateuMaxY)
  }
    
  private func createRovers(from instructions: [String]) throws {
    guard !instructions.isEmpty else {
      throw RoverCommandError.invalidRoverInstructions
    }
    
    try instructions.enumerated().forEach { index, instruction in
      if index % 2 == 0 {
        let roverStartPosition = instruction
        let roverCommandLine = instructions[index + 1]
        try makeRover(from: roverStartPosition, commandLine: roverCommandLine)
      }
    }
  }
  
  private func makeRover(from startPosition: String, commandLine: String) throws {
    let roverStartPositinValues = startPosition.split(separator: " ")
    
    guard roverStartPositinValues.count == 3,
          let x = Int(roverStartPositinValues[0]),
          let y = Int(roverStartPositinValues[1]) else {
      throw RoverCommandError.invalidRoverInstructions
    }
    
    let initialRoverOrientation = Orientation(String(roverStartPositinValues[2]))
    let roverPosition = RoverPosition(coordinates: Coordinates(x: x, y: y), orientation: initialRoverOrientation)
    
    let rover = Rover(position: roverPosition)
    
    let initialCommandInstructions = commandLine.map { String($0) }
    rover.update(moveInstructions: initialCommandInstructions)
    
    rovers.append(rover)
  }
}
  
