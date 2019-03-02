import 'package:http/http.dart';
import 'package:dartla_util/src/universal_resource/query_result.dart';
import 'package:dartla_util/src/universal_resource/resource.dart';
import 'package:uri/uri.dart';

typedef Q BodyParser<T, Q extends QueryResult<T>>(String body);

class HttpResource<T, Q extends QueryResult<T>> implements Resource<T, Q, String> {
  String baseUrl;
  UriTemplate path;
  Client client;
  BodyParser<T ,Q> bodyParser;

  HttpResource._({this.baseUrl, this.path, this.client, this.bodyParser});

  factory HttpResource(
      {String baseUrl, String path, Client client, BodyParser<T, Q> bodyParser}) {
    return new HttpResource._(
        client: client,
        bodyParser: bodyParser,
        path: new UriTemplate(path),
        baseUrl: baseUrl);
  }

  @override
  Future<Null> save(Iterable<T> instances) async {
    return null;
  }

  @override
  Future<Iterable<T>> find(Map<String, String> where) async {
    String uri = Uri.https(baseUrl, path.expand(where), where).toString();

    Response response = await client.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return bodyParser(response.body).records;
    }
    return [];
  }

  @override
  Future<Q> findAndCount(Map<String, String> where) async {
    String uri = Uri.https(baseUrl, path.expand(where), where).toString();
    Response response = await client.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return bodyParser(response.body);
    }
    throw Error();
  }
}
