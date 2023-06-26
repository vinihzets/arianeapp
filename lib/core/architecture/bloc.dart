import 'dart:async';

import 'package:ariane_app/core/architecture/bloc_event.dart';

import 'package:ariane_app/core/architecture/bloc_state.dart';

import 'mixins/hud_mixin.dart';

abstract class Bloc with HudMixins {
  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<BlocEvent> _event;
  Sink<BlocEvent> get event => _event.sink;

  Bloc() {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(mapListenEvent);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  dispatchEvent(BlocEvent event) {
    _event.add(event);
  }

  mapListenEvent(BlocEvent event);
}
