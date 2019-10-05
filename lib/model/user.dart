class User {
  String _id;
  String _fullName;
  String _phoneNumber;

  User.name(this._id, this._fullName, this._phoneNumber);


  User.fromJson(Map json){
    _id = json['id'];
    _fullName = json['fullName'];
    _phoneNumber = json['phoneNumber'];
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}