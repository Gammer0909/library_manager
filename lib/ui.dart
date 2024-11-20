import 'dart:core';
import 'dart:ffi';
import 'dart:io';

import 'package:library_management/book.dart';
import 'package:library_management/library.dart';
import 'package:library_management/library_user.dart';

void startApplication() {
  Library lib = Library.empty();
  clear();
  stdout
      .writeln("Library Manager, (c) Kyle Garzon 2024\nType 'help' for help.");
  while (true) {
    String input = getInput();
    switch (input) {
      case "HELP":
      case "help":
        printHelp();
        break;
      case "EXIT":
      case "exit":
        exit(0);
      case "LIST":
      case "list":
        for (int i = 0; i < lib.users.length; i++) {
          String name = lib.users[i].userName;
          stdout.write("$name | ");
          var books = lib.users[i].checkedOut;
          stdout.writeln("Checked out: $books");
        }
        break;
      case "BOOKS":
      case "books":
        for (int i = 0; i < lib.available.length; i++) {
          String title = lib.available[i].getTitle();
          String author = lib.available[i].getAuthor();
          int id = lib.available[i].getId();
          stdout.writeln("$title by $author ID: $id");
        }
      case "AVAILABLE":
      case "available":
        for (int i = 0; i < lib.available.length; i++) {
          if (!lib.available[i].isAvailable) {
            continue;
          }
          String title = lib.available[i].getTitle();
          String author = lib.available[i].getAuthor();
          int id = lib.available[i].getId();
          stdout.writeln("$title by $author ID: $id");
        }
      case "ADD":
      case "add":
        stdout.writeln("Book title:");
        String title = getIn();
        stdout.writeln("Book author:");
        String author = getIn();
        Book b = Book(title, author, lib.getNewestId() + 1);
        lib.available.add(b);
        int i = lib.getNewestId() - 1;
        stdout.writeln(
            "New book registered:\n\nTitle: $title\nAuthor: $author\nID: $i\n");
        break;
      case "REGISTER":
      case "register":
        stdout.writeln("User's Name: ");
        String name = getIn();
        LibraryUser u = LibraryUser(name);
        lib.users.add(u);
        stdout.writeln("New user $name registered to the library.");
        break;
      case "REMOVE":
      case "remove":
        stdout.writeln("Enter user's name to remove: ");
        String name = getIn();
        try {
          LibraryUser u = lib.getUser(name);
          lib.users.remove(u);
        } catch (e) {
          stdout.writeln("User $name does not exist.");
        }
        stdout.writeln("User $name was removed.");
      case "RETURN":
      case "return":
        stdout.writeln("The name of the book to return: ");
        String title = getIn();
        try {
          Book b = lib.getBook(title);
          LibraryUser u = lib.getBorrower(b);
          lib.returnBook(b);
          stdout.writeln("Book $b returned from $u successfully.");
        } catch (e) {
          stdout.writeln("An error occured: $e");
        }
        break;
    }
  }
}

void printHelp() {
  stdout.writeln(
      "List of commands:\n\n-------------------------------------------------------------------\n");
  stdout.writeln("ADD : Adds a new book to the library registry.");
  stdout.writeln(
      "CHECKOUT : Checks out the book of a given title, if it's available.");
  stdout.writeln("HELP : Show list of commands.");
  stdout.writeln("BOOKS : List all books.");
  stdout.writeln("AVAILABLE : List all available books.");
  stdout.writeln("LIST : List all users.");
  stdout.writeln("REGISTER : Register a new librarygoer.");
  stdout.writeln("REMOVE : Remove the user `name`, if they exist.");
  stdout.writeln("RETURN : Return the book of a given title.");
  stdout.writeln("EXIT : Exit the management system.");
}

/// Get input from command line, but for something other than for a command
String getIn() {
  String? ret;
  stdout.write("> ");
  ret = stdin.readLineSync();
  if (ret == null) {
    clear();
    return getIn();
  }
  return ret;
}

String getInput() {
  stdout.write("> ");
  String? input = stdin.readLineSync();
  if (input == null) {
    stdout.writeln("Error: `null` was received; please enter valid input.\n");
    printHelp();
    return getInput();
  }
  return input;
}

void clear() {
  stdout.write('\x1B[2J\x1B[0;0H');
}
