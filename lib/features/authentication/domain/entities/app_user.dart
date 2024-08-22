import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({required this.id});
  const AppUser.empty() : this(id: "");

  final String id;

  bool get isEmpty => id.isEmpty;

  @override
  List<Object?> get props => [id];
}
