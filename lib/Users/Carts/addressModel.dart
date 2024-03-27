
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressItem {
  AddressItem({
    required this.Address,
    required this.FullName,
    required this.PhoneNumber,
    required this.email,
    required this.id,
  });
  late final String Address;
  late final String FullName;
  late final String PhoneNumber;
  late final String email;
  late final String id;

  AddressItem.fromJson(DocumentSnapshot json) {
    Address = json['Address'];
    FullName = json['FullName'];
    PhoneNumber = json['PhoneNumber'];
    email = json['Email'];
    id = json.id;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Address'] = Address;
    _data['FullName'] = FullName;
    _data['PhoneNumber'] = PhoneNumber;
    _data['Email'] = email;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AddressItem &&
              runtimeType == other.runtimeType &&
              Address == other.Address &&
              FullName == other.FullName &&
              PhoneNumber == other.PhoneNumber &&
              email == other.email &&
              id == other.id;

  @override
  int get hashCode =>
      Address.hashCode ^ FullName.hashCode ^ PhoneNumber.hashCode ^ email.hashCode ^ id.hashCode;
}
