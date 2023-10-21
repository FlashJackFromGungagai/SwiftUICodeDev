//
//  GeocodeDataStruture.swift
//  LocnMpScrnPortView
//
//  Created by mlittle-macmini-20200921 on 21/10/2023.
//

/// The geocoding data strcture is defined by the Google API, please refern to
///   https://developers.google.com/maps/documentation/geocoding/start
///   for more information.
///   This geocoding data structure extracts the latitude and longitude information
///   for the string address that is fed in.
///   this will then be used to present the location on Apple maps.

/*

About:
——————————————
This code has been adapted from "WeatherAppDemoApp.swift" by
 by Shekhar Kalra on 3/9/2023
 
 

Change History:
——————————————


Version :
——————————————


Contact:
——————————————
Developed by:
Mike Little
Student ID: s9905648
Mob:    +613 476 136 482
Email:  "s9905648@student.rmit.edu"

*/


import Foundation
import SwiftUI
import Combine


// ================================================================================
/// this is because the first element that is returned in the JSON file is "results"
struct geocodeResultsData: Decodable
{
    var results: [resultsGeometry]
    
}// close struct geocodeResultsData: Decodable

// ================================================================================
/// Under "results" there are a number of elements including "place_id", however we are only interested in the latitude and longitude that is found under "geometry" Element
struct resultsGeometry : Decodable
{
    var geometry: geometryLocation


}// close struct geometryResults : Decodable

// ================================================================================
/// under the "geometry" Element is the "Location" Element that contains the latitude and longitude

struct geometryLocation :Decodable
{

    var location :  locationLatLng

}// close struct geometryLocation :Decodable

// ================================================================================
/// Under the "Location" Element is the items that we wish to return, the latitude and longitude for
/// the string address.
struct locationLatLng :Decodable
{

    var lat: Double
    var lng: Double


}// close struct locationLatLng :Decodable

// ================================================================================
