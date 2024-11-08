import 'dart:io';

enum BookStatus { available, borrowed }

class Book {
  String _title;
  String _author;
  String _isbn;
  BookStatus _status;

  Book(this._title, this._author, this._isbn, this._status);

  @override
  String toString() {
    return "Title: $_title, Author: $_author, ISBN: $_isbn, Status: ${_status.toString()} \n\n";
  }

  // Getters and setters
  set setTitle(String title) => _title = title;
  set setAuthor(String author) => _author = author;
  set setIsbn(String isbn) => _isbn = isbn;
  set setStatus(BookStatus status) => _status = status;

  String get title => _title;
  String get author => _author;
  String get isbn => _isbn;
  BookStatus get status => _status;

  void updateStatus(BookStatus status) {
    _status = status;
  }
}

class TextBook extends Book {
  String subjectArea;
  String gradeLevel;

  TextBook(super.title, super.author, super.isbn, super.status,
      this.subjectArea, this.gradeLevel);

  @override
  String toString() {
    return super.toString() +
        "Subject Area: $subjectArea, Grade Level: $gradeLevel";
  }

  // Getters and setters
  set setSubjectArea(String subjectArea) => this.subjectArea = subjectArea;
  set setGradeLevel(String gradeLevel) => this.gradeLevel = gradeLevel;
}

class BookManage {
  List<Book> _books = [];

 void addBook() {
    stdout.write("Enter Title: ");
    String title = stdin.readLineSync() ?? '';
    stdout.write("Enter Author: ");
    String author = stdin.readLineSync() ?? '';
    stdout.write("Enter ISBN: ");
    String isbn = stdin.readLineSync() ?? '';

    while (!isValidISBN(isbn)) {
      stdout.write("Invalid ISBN. Re-enter ISBN: ");
      isbn = stdin.readLineSync() ?? '';
    }

    BookStatus status = BookStatus.available;
    Book newBook = Book(title, author, isbn, status);
    _books.add(newBook);
    print("Book added successfully.\n");
  }

  bool isValidISBN(String isbn) {
    if (isbn.length != 13) {
      return false;
    }
    for (int i = 0; i < isbn.length; i++) {
      if (!isNumeric(isbn[i])) {
        return false;
      }
    }
    for(Book book in _books) {
      if (book.isbn == isbn) {
        return false;
      }
    }
    return true;
  }

  bool isNumeric(String charString) {
    return charString.codeUnitAt(0) >= 48 && charString.codeUnitAt(0) <= 57;
  }

  void updateBook() {
    stdout.write("Enter Title of the book to update: ");
    String updateTitle = stdin.readLineSync() ?? '';

    try {
      Book bookToUpdate = _books.firstWhere((book) => book.title == updateTitle);
      stdout.write("Enter new Title: ");
      String newTitle = stdin.readLineSync() ?? '';
      stdout.write("Enter new Author: ");
      String newAuthor = stdin.readLineSync() ?? '';
      stdout.write("Enter new ISBN: ");
      String newIsbn = stdin.readLineSync() ?? '';
      while (!isValidISBN(newIsbn)) {
        stdout.write("Invalid ISBN. Re-enter ISBN: ");
        newIsbn = stdin.readLineSync() ?? '';
      }

      bookToUpdate
        ..setTitle = newTitle
        ..setAuthor = newAuthor
        ..setIsbn = newIsbn;

      print("Book updated successfully.\n");
    } catch (e) {
      print("Book not found.\n");
    }
  }


  void removeBook() {
    stdout.write("Enter Title of the book to remove: ");
    String removeTitle = stdin.readLineSync() ?? '';
    _books.removeWhere((book) => book.title == removeTitle);
    print("Book removed.\n");
  }

 void searchByTitle() {
    stdout.write("Enter Title to search: ");
    String searchTitle = stdin.readLineSync() ?? '';
    List<Book> results = _books.where((book) => book.title == searchTitle).toList();
    if (results.isEmpty) {
      print("No books found with the given title.\n");
    } else {
      print("Search Results:");
      results.forEach(print);
    }
  }

  void searchByAuthor() {
    stdout.write("Enter Author to search: ");
    String searchAuthor = stdin.readLineSync() ?? '';
    List<Book> results = _books.where((book) => book.author == searchAuthor).toList();
    if (results.isEmpty) {
      print("No books found with the given author.\n");
    } else {
      print("Search Results:");
      results.forEach(print);
    }
  }

  void displayMenu() {
    print("================================ Book Manage =================================\n");
    print("[1] Add book");
    print("[2] Update book");
    print("[3] Remove book");
    print("[4] Search by title");
    print("[5] Search by author");
    print("[6] Exit\n");
    stdout.write("Enter choice: ");
  }

  void handleChoice(int choice) {
    switch (choice) {
      case 1:
        addBook();
        break;
      case 2:
        updateBook();
        break;
      case 3:
        removeBook();
        break;
      case 4:
        searchByTitle();
        break;
      case 5:
        searchByAuthor();
        break;
      case 6:
        print("Exiting program. Goodbye!");
        exit(0);
      default:
        print("Invalid selection.\n");
    }
  }



}

void main() {
  BookManage bookManage = BookManage();
  while (true) {
    bookManage.displayMenu();
    int? choice = int.tryParse(stdin.readLineSync() ?? '');
    if (choice != null) {
      bookManage.handleChoice(choice);
    } else {
      print("Invalid input. Please enter a number.\n");
    }
  }

  
}
