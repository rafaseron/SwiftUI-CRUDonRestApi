//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import Foundation

struct WebService {
    
    private let baseURL = "http://192.168.100.36:3000"
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let getEndpoint = "\(baseURL)/especialista"
        
        guard let url = URL(string: getEndpoint) else {
            print("URL Error")
            return nil
        }
        
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: getRequest)
        
        let dataDecode = try JSONDecoder().decode([Specialist].self, from: data)
        return dataDecode
    }
    
}
