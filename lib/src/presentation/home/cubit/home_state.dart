import 'package:traction_selection_proccess/src/domain/company/entity/company_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}


class HomeLoaded extends HomeState {
  final List<CompanyEntity> companies;
  HomeLoaded({required this.companies});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

class HomeLoading extends HomeState {
  final List<CompanyEntity> companies = const [
    CompanyEntity(id: "", name: "Tractian: Tecnologia"),
    CompanyEntity(id: "", name: "Tractian: Tecnologia"),
    CompanyEntity(id: "", name: "Tractian: Tecnologia"),
  ];
}