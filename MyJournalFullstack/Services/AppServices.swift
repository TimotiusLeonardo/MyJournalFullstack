//
//  AppServices.swift
//  MyJournalFullstack
//
//  Created by IDN MEDIA on 06/05/21.
//

import Foundation

class AppServices: NSObject {
    static let shared = AppServices()
    
    func fetchPosts(completion: @escaping (Result<[HomeModel], Error>) -> ()) {
        guard let url = URL(string: "http://localhost:1337/posts") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch posts: ", err)
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let posts = try JSONDecoder().decode([HomeModel].self, from: data)
                    completion(.success(posts))
                }catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func createPost(title: String, body: String, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let params = ["title": title, "postBody": body]
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, resp, err ) in
                guard let data = data else { return }
                completion(nil)
            }.resume()
            
        } catch {
            completion(error)
        }
    }
    
    func deletePost(id: Int, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post/\(id)") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlRequest) { data, resp, err in
            DispatchQueue.main.async {
                if let err = err {
                    completion(err)
                    return
                }
                completion(nil)
                
                if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                    let errorString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    completion(NSError(domain: "", code: resp.statusCode, userInfo: [NSLocalizedDescriptionKey : errorString]))
                }
            }
        }.resume()
        
    }
}
