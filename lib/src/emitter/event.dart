class Event<T> {
  final String name;
  final T data;

  Event(this.name, this.data);

  Event<E> cast<E>() {
    return Event<E>(name, data as E);
  }
}
