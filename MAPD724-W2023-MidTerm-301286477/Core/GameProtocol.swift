//MAPD724 - Advanced iOS Development
//Midterm Test
//Modify Mail Pilot
//Victor Quezada - 301286477

protocol GameProtocol
{
    // Initialization
    func Start()
    
    // update every frame
    func Update()
    
    // check if the position is outside the bounds of the Screen
    func CheckBounds()
    
    // a method to reset the position
    func Reset()
}
