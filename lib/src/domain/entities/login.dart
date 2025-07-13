class Login {
  final String phone;
  final String code;

  Login({required this.phone, required this.code});

  //toJson
  Map<String, dynamic> toJson() => {'phone': phone, 'code': code};

  //fromJson
  factory Login.fromJson(Map<String, dynamic> json) =>
      Login(phone: json['phone'], code: json['code']);

  //toString
  @override
  String toString() => 'Login(phone: $phone, code: $code)';

  //copyWith
  Login copyWith({String? phone, String? code}) =>
      Login(phone: phone ?? this.phone, code: code ?? this.code);
}
