class Account {
  final int id;
  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final bool activated;
  final String langKey;
  final String createdBy;
  final String? createdDate;
  final String lastModifiedBy;
  final String? lastModifiedDate;
  final List<dynamic> authorities;

  Account({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.activated,
    required this.langKey,
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
    required this.authorities,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: (json['id'] as num?)?.toInt() ?? 0,
      login: json['login'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      imageUrl: (json['imageUrl'] as String?) ?? '',
      activated: json['activated'] as bool,
      langKey: json['langKey'] as String,
      createdBy: (json['createdBy'] as String?) ?? '',
      createdDate: (json['createdDate'] as String?) ?? '',
      lastModifiedBy: (json['lastModifiedBy'] as String?) ?? '',
      lastModifiedDate: (json['lastModifiedDate'] as String?) ?? '',
      authorities: (json['authorities'] as List<dynamic>?) ?? [],
    );
  }
}
