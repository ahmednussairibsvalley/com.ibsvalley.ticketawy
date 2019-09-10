class Event{
  int _id;
  String _title;
  String _imageUrl;

  Event(this._id, this._title, this._imageUrl);

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


}