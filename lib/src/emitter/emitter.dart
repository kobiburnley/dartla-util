import 'dart:async';

import 'package:dartla_util/src/emitter/event.dart';
import 'package:dartla_util/src/emitter/listener.dart';

mixin Emitter {
  StreamController<Event<dynamic>> streamController = new StreamController.broadcast();

  Stream<Event<dynamic>> get stream => streamController.stream;

  void emit<T>(Iterable<String> eventNames, T t) {
    for (String eventName in eventNames) {
      streamController.add(Event(eventName, t));
    }
  }

  Iterable<StreamSubscription<Event<dynamic>>> on<T>(Iterable<String> eventNames, Listener<Event<T>> listener) {
    return eventNames.map((String eventName) {
      return stream.listen((event) {
        if (event.name == eventName) {
          listener(event.cast());
        }
      });
    }).toList();
  }
}
