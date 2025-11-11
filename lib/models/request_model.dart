class RequestModel {
  const RequestModel({
    this.urlApi,
    this.method = Method.GET,
    this.params,
    this.headers,
    this.auth,
  });

  // StartPoint and EndPoint, Param
  final String urlApi;
  final dynamic params;
  final Method method;
  final Map<String, String> headers;
  final Map<String, String> auth;
}

enum Method { GET, POST, PUT, DELETE }
