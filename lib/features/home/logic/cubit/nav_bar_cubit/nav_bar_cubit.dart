import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  int currentIndex=0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChanged(currentIndex));
  }
}
