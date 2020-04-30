part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({@required this.activeTab}) : assert(activeTab != null);

  final HomeTab activeTab;

  @override
  List<Object> get props => [activeTab];

  @override
  bool get stringify => true;
}
