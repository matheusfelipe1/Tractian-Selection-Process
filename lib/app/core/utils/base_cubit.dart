
import 'package:bloc/bloc.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState) {
    onInit();
  }

  void onInit();
}