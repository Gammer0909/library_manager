class Book {
  final String _title;
  final String _author;
  final int _id;
  bool isAvailable = true;

  // wow, thats nice sugar
  Book(this._title, this._author, this._id);

  String getTitle() {
    return _title;
  }

  String getAuthor() {
    return _author;
  }

  int getId() {
    return _id;
  }

  @override
  String toString() {
    return _title;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Book) {
      return false;
    }
    Book b = other as Book;
    return (_title == b.getTitle()) && (_author == b.getAuthor()) && (_id == b.getId());
  }
}