class AppUser {
  const AppUser({required this.id});
  const AppUser.empty() : this(id: "");

  final String id;

  bool get isEmpty => id.isEmpty;
}
