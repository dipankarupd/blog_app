class Profile {
  final String id;
  final String email;
  final String username;

  Profile({
    required this.id,
    required this.email,
    required this.username,
  });
}


// added in core
// core does not depend on features
// features can depend on core