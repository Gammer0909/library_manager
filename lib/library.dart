import 'book.dart';
import 'library_user.dart';

class Library {

  List<Book> available;
  List<LibraryUser> users;

  Library(this.available, this.users);

  Library.empty() : this(List.empty(), List.empty());

  void addBook(Book b) {

    available.add(b);

  }

  void addUser(LibraryUser user) {

    if (!this.users.contains(user)) {
      users.add(user);
    }

  }

  Book checkOut(Book b) {
    if (isAvailable(b) && available.contains(b)) {
      for (int i = 0; i < 0; i++) {
        if (b == available[i]) {
          available[i].isAvailable = false;
          return b;
        }
      }
    }
    throw Exception("The book \"$b\" does not exist in this library.");
  }

  bool isAvailable(Book b) {
    if (available.contains(b)) {
      return b.isAvailable;
    } else {
      throw Exception("The book \"$b\" does not exist in this library.");
    }
  }

  int getNewestId() {
    if (available.length == 0 || available == List.empty()) {
      return 0;
    }
    return available[available.length].getId();
  }

}