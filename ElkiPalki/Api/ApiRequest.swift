import Foundation

enum ApiErrors: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
    case responseProblemTyt
    case apiError(String)
}

struct ApiRequest {
    let resourseURL: URL
    
    init (endPoint: String) {
        let resourseURL = "https://elpal.herokuapp.com/\(endPoint)"
        
        guard let resourseURL = URL(string: resourseURL) else {fatalError()}
        
        self.resourseURL = resourseURL
    }
    
    func registration(_ userInfo: UsetAuthorization, completion: @escaping(Result<Tokens, ApiErrors>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourseURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userInfo)
            
            
            let task = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    do {
                        let responseData = try JSONDecoder().decode(Tokens.self, from: jsonData)
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else if httpResponse.statusCode == 400 {
                    do {
                        let responseData = try JSONDecoder().decode(Errors.self, from: jsonData)
                        completion(.failure(.apiError(responseData.message)))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else {
                    completion(.failure(.responseProblem))
                }
            }
            task.resume()

        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func login(_ userInfo: UsetAuthorization, completion: @escaping(Result<Tokens, ApiErrors>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourseURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userInfo)
            
            let task = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    do {
                        let responseData = try JSONDecoder().decode(Tokens.self, from: jsonData)
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else if httpResponse.statusCode == 400 {
                    do {
                        let responseData = try JSONDecoder().decode(Errors.self, from: jsonData)
                        completion(.failure(.apiError(responseData.message)))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else {
                    completion(.failure(.responseProblem))
                }
            }
            task.resume()

        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    
    
    func updateUserInfo(_ userInfo: UserInfoModel, completion: @escaping(Result<Bool, ApiErrors>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourseURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userInfo)

            
            let task = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                      let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    completion(.success(true))
                } else if httpResponse.statusCode == 400 {
                    do {
                        let responseData = try JSONDecoder().decode(Errors.self, from: jsonData)
                        completion(.failure(.apiError(responseData.message)))
                    } catch {
                        completion(.failure(.decodingProblem))
                    }
                } else {
                    completion(.failure(.responseProblem))
                }
            }
            task.resume()

        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    
    
    func getAllObjects(completion: @escaping(Result<Objects, ApiErrors>) -> Void) {
        let task = URLSession.shared.dataTask(with: resourseURL) {data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse,
                  let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
        
            if httpResponse.statusCode == 200 {
                do {
                    let responseData = try JSONDecoder().decode(Objects.self, from: jsonData)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            } else if httpResponse.statusCode == 400 {
                do {
                    let responseData = try JSONDecoder().decode(Errors.self, from: jsonData)
                    completion(.failure(.apiError(responseData.message)))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            } else {
                completion(.failure(.responseProblemTyt))
            }
        }
        task.resume()
    }
    
    func getFullInfoAboutObject(completion: @escaping(Result<NewObject, ApiErrors>) -> Void) {
        let task = URLSession.shared.dataTask(with: resourseURL) {data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse,
                  let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
        
            if httpResponse.statusCode == 200 {
                do {
                    let responseData = try JSONDecoder().decode(NewObject.self, from: jsonData)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            } else if httpResponse.statusCode == 400 {
                do {
                    let responseData = try JSONDecoder().decode(Errors.self, from: jsonData)
                    completion(.failure(.apiError(responseData.message)))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            } else {
                completion(.failure(.responseProblemTyt))
            }
        }
        task.resume()
    }
    
    func getImage(completion: @escaping(Result<Data, ApiErrors>) -> Void) {
        let task = URLSession.shared.dataTask(with: resourseURL) {data, response, _ in
            guard let _ = response as? HTTPURLResponse,
                  let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            completion(.success(jsonData))
            
        }
        task.resume()
    }
}

