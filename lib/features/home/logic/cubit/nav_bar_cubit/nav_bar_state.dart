part of 'nav_bar_cubit.dart';

@immutable
abstract class NavBarState {}

class NavBarInitial extends NavBarState {}
class NavBarChanged extends NavBarState {
  final int selectedIndex;

  NavBarChanged(this.selectedIndex);
}
