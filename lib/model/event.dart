class Event{
  int _id;
  String _title;
  String _imageUrl;
  double _price;
  int _reservationOption;

  Event(this._id, this._title, this._imageUrl, this._price, this._reservationOption);

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get reservationOption => _reservationOption;

  set reservationOption(int value) {
    _reservationOption = value;
  }


}