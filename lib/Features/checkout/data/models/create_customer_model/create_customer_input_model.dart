class CreateCustomerInputModel {
  final String name;
  final String email;

  CreateCustomerInputModel({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
