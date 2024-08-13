//
//  Appointment.swift
//  Vollmed
//
//  Created by Rafael Seron on 28/07/24.
//

import Foundation

struct Appointment: Identifiable, Codable{
    let id: String
    let appointmentDate: String
    let specialist: Specialist
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case appointmentDate = "data"
        case specialist = "especialista"
    }
    
}

struct AppointmentRequest: Encodable{
    let date: String
    let appointmentId: String
}

struct AppointmentResponse: Decodable{
    
    // case failure
    let status: Int
    let message: String
    
    // case sucess
    let specialist: String
    let patient: String
    let date: String
    let cancelReason: String
    let Id: String
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case message = "message"
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
        case cancelReason = "motivoCancelamento"
        case iD = "id"
        
        
    }
    
}
