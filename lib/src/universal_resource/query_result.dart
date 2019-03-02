abstract class QueryResult<T> {
  int get total;
  Iterable<T> get records;
}
