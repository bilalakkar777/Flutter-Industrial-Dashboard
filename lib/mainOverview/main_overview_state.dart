import 'package:flutter_bloc/flutter_bloc.dart';

enum EMainOverviewWideMenu {
  home,
  introduction,
  mining,
  delivery,
  automation,
  operator
}

class MainOverviewState {
  MainOverviewState();

  get isHomeSelected => selectedSubmenu == EMainOverviewWideMenu.home;
  get isIntroductionSelected =>
      selectedSubmenu == EMainOverviewWideMenu.introduction;
  get isMiningSelected => selectedSubmenu == EMainOverviewWideMenu.mining;
  get isDeliverySelected => selectedSubmenu == EMainOverviewWideMenu.delivery;
  get isAutomationSelected =>
      selectedSubmenu == EMainOverviewWideMenu.automation;
  get isOperatorSelected => selectedSubmenu == EMainOverviewWideMenu.operator;

  int wideMenuFlexLeft = 2;
  int wideMenuFlexRight = 44;

  EMainOverviewWideMenu selectedSubmenu = EMainOverviewWideMenu.home;

  //make a copyWith method
  copyWithSelectedSubMenu(EMainOverviewWideMenu selectedSubmenu) =>
      MainOverviewState()..selectedSubmenu = selectedSubmenu;
}

class MainOverviewCubit extends Cubit<MainOverviewState> {
  MainOverviewCubit() : super(MainOverviewState());

  void onHomeTap() {
    emit(state.copyWithSelectedSubMenu(EMainOverviewWideMenu.home));
  }

  void onIntroductionTap() {
    emit(state.copyWithSelectedSubMenu(EMainOverviewWideMenu.introduction));
  }

  void onMiningTap() {
    emit(state.copyWithSelectedSubMenu(EMainOverviewWideMenu.mining));
  }

  void onDeliveryTap() {
    emit(state.copyWithSelectedSubMenu(EMainOverviewWideMenu.delivery));
  }

  void onAutomationTap() {
    emit(state.copyWithSelectedSubMenu(EMainOverviewWideMenu.automation));
  }

  void onOperatorTap() {
    emit(state.copyWithSelectedSubMenu(EMainOverviewWideMenu.operator));
  }
}
