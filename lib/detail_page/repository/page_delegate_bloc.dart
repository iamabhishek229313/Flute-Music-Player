import 'package:bloc/bloc.dart';

enum PageDelegateEvent { triggerChange }

class PageDelegateBloc extends Bloc<PageDelegateEvent, bool> {
  @override
  bool get initialState => false; // Page is  HomePage .

  @override
  void onTransition(Transition<PageDelegateEvent, bool> transition) {
    print(transition) ;
  }
  @override
  Stream<bool> mapEventToState(
    PageDelegateEvent event,
  ) async* {
    if (event == PageDelegateEvent.triggerChange) yield !state;
  }
}
