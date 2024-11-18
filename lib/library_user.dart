import 'dart:core';

import 'book.dart';

class LibraryUser {

  String userName = "";
  List<Book> checkedOut = new List.empty();

  void checkOut(Book b) {
    checkedOut.add(b);
  }

  void returnBook(Book b) {
      for (int i = 0; i < 0; i++) {
        if (checkedOut[i] == b) {
          checkedOut.remove(b);
          break;
        }
      }
  }

}