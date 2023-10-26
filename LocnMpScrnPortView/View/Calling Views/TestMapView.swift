//
//  ContentView.swift
//  TestMap
//
//  Created by mlittle-macmini-20200921 on 21/10/2023.
//

/*

About:
——————————————

 

Change History:
——————————————


Version :
——————————————


Contact:
——————————————
Mike Little
Mob:    +613 476 136 482
Email:  "s9905648@student.rmit.edu"

*/


import SwiftUI
import Combine
import MapKit

//=============================================================================
struct TestMapView: View
{   //melbourne, victoria
    //@State var latitud: Double = -37.8136
    //@State var longitud: Double = 144.9631
    
    // perth, Western Australia
    @State var latitud: Double = -31.9523
    @State var longitud: Double = 115.8613
    
    
    
    @State var navToMapIsActive: Bool = false
    
    //———————————————————————————————————————————————————————
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                Text("Show the map for the following location:")
                // here you want to pass in
                Text("latitude:\(latitud) and longitude: \(longitud)")
                Button("Show Map")
                {
                    navToMapIsActive.toggle()
                }
                .sheet(isPresented: $navToMapIsActive )
                {
                    ViewMap(latitud:$latitud,longitud:$longitud )
                    // this calls the coresponding map
                    
                }// close ".sheet(isPresented: $navToMapIsActive )
                
            }// close VStack
        
        }// close NavigationView

     }//close var body: some View
    
    //———————————————————————————————————————————————————————
}// close struct TestMapView: View



//=============================================================================
struct TestMapView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TestMapView()
    }
}
//=============================================================================
