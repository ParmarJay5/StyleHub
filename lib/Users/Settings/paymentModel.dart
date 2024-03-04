class PaymentModel {
  final String orderId;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String paymentMethod;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  // final St

  PaymentModel({
    required this.orderId,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.paymentMethod,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'paymentMethod': paymentMethod,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }
}
