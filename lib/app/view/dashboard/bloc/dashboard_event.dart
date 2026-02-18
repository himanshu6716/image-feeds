part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class LoadImagesEvent extends DashboardEvent {}

class PickImagesEvent extends DashboardEvent {}

class DeleteImageEvent extends DashboardEvent {
  final int index;
  DeleteImageEvent(this.index);
}
