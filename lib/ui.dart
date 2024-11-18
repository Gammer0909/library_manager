import 'dart:core';
import 'dart:io';

void startApplication() {
  clear();
  stdout.writeln("Library Manager, (c) Kyle Garzon 2024\nType 'help' for help.");
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
      case "ADD":
      case "add":
        
    }
  }  

}

void printHelp() {
  stdout.writeln("List of commands:\n\n-------------------------------------------------------------------\n");
  stdout.writeln("ADD : Adds a new book to the library registry.");
  stdout.writeln("CHECKOUT : Checks out the book of a given title, if it's available.");
  stdout.writeln("HELP : Show list of commands.");
  stdout.writeln("LIST : list available books.");
  stdout.writeln("REGISTER : Register a new librarygoer.");
  stdout.writeln("REMOVE : Remove the user `name`, if they exist.");
  stdout.writeln("RETURN : Return the book of a given title.");
  stdout.writeln("EXIT : Exit the management system.");
}

/// Get input from command line, but for something other than for a command
String getIn() {
  String? ret = null;
  do {
    stdout.write("> ");
    ret = stdin.readLineSync();
  } while (ret != null);
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