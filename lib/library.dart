import 'dart:io';

import 'book.dart';
import 'library_user.dart';

class Library {
  List<Book> available;
  List<LibraryUser> users;

  Library(this.available, this.users);

  Library.empty()
      : this(List.empty(growable: true), List.empty(growable: true));

  void addBook(Book b) {
    available.add(b);
  }

  void addUser(LibraryUser user) {
    if (!users.contains(user)) {
      users.add(user);
    }
  }

  void returnBook(Book b) {
    if (b.isAvailable) {
      throw Exception("Book is already returned.");
    }
    try {
      LibraryUser u = getBorrower(b);
      u.checkedOut.remove(b);
    } catch (e) {
      stdout.writeln();
    }
  }

  void checkOut(Book b, String user) {
    if (!userExists(user)) {
      throw Exception(
          "User $user does not exist, please register a new user or enter a valid name.");
    }
    if (isAvailable(b) && available.contains(b)) {
      for (int i = 0; i < users.length; i++) {
        if (b == available[i]) {
          LibraryUser u = getUser(user);
          available[i].isAvailable = false;
          u.checkedOut.add(b);
          return;
        }
      }
    }
    throw Exception("The book \"$b\" does not exist in this library.");
  }

  LibraryUser getUser(String name) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].userName == name) {
        return users[i];
      }
    }
    throw Exception("User $name does not exist.");
  }

  bool userExists(String name) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].userName == name) {
        return true;
      }
    }
    return false;
  }

  bool isAvailable(Book b) {
    if (available.contains(b)) {
      return b.isAvailable;
    } else {
      throw Exception("The book \"$b\" does not exist in this library.");
    }
  }

  Book getBook(String title) {
    for (int i = 0; i < available.length; i++) {
      if (available[i].getTitle() == title) {
        return available[i];
      }
    }
    throw Exception("Book does not exist.");
  }

  LibraryUser getBorrower(Book b) {
    for (int i = 0; i < users.length; i++) {
      for (int j = 0; j < users[i].checkedOut.length; j++) {
        if (b == users[i].checkedOut[j]) {
          return users[i];
        }
      }
    }
    throw Exception("No user has the book provided.");
  }

  int getNewestId() {
    return available.length;
  }

  void save() {}
}
