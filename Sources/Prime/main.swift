import AWSLambdaRuntime
import AWSLambdaEvents
import Foundation

struct Output: Codable {
  let count: Int
  let maxPrime: Int
  let duration: Double
}

let jsonEncoder = JSONEncoder()

// url?limit=number
// https://dasfdsa.amazo.com/prime?limit=10

Lambda.run {
  (context,
   request: APIGateway.V2.Request ,
   callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void ) in
  
  let response: APIGateway.V2.Response
  
  guard request.context.http.method == .GET else {
    response = APIGateway.V2.Response(statusCode: .badRequest)
    callback(.success(response))
    return
  }
  
  guard let limit = Int(request.queryStringParameters?["limit"] ?? "") else {
    response = APIGateway.V2.Response(statusCode: .badRequest)
    callback(.success(response))
    return
  }
  
  var primes = [Int]()
  let duration = timeElapsedInSecondsWhenRunningCode {
    primes = findPrimesUntil(limit)
  }
  
  let responseData = Output(count: primes.count,
                            maxPrime: primes.last ?? 0,
                            duration: duration * 1000)
  
  do {
    let body = try jsonEncoder.encodeAsString(responseData)
    response = APIGateway.V2.Response(statusCode: .ok,
                                      headers: HTTPHeaders(dictionaryLiteral: ("content-type", "application/json")),
                                      body: body)
    callback(.success(response))
  } catch {
    response = APIGateway.V2.Response(statusCode: .internalServerError)
    callback(.success(response))
  }
}

