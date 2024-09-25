import 'package:traction_selection_process/app/domain/company/entity/company.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Company> companies;
  HomeLoaded({required this.companies});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

class HomeLoading extends HomeState {
  final List<Company> companies = const [
    Company(id: "", name: "Tractian: Tecnologia"),
    Company(id: "", name: "Tractian: Tecnologia"),
    Company(id: "", name: "Tractian: Tecnologia"),
  ];
}
