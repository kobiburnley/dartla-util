import 'package:dartla_util/src/universal_resource/query_result.dart';

abstract class Resource<T, Q extends QueryResult<T>, W> {
  Future<Iterable<T>> find(Map<String, W> where);

  Future<Q> findAndCount(Map<String, W> where);

  Future<Null> save(Iterable<T> instances);
}
