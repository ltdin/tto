import 'package:bloc/bloc.dart';
import 'package:news/base/app_helpers.dart';

class AppBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    printDebug('Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printDebug('State: ${transition.nextState}');
  }
}
