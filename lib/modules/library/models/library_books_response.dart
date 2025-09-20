import 'package:salamat/modules/library/models/library_book.dart';

class LibraryBooksResponse {
  final LibraryBooksData data;

  LibraryBooksResponse({required this.data});

  factory LibraryBooksResponse.fromJson(Map<String, dynamic> json) {
    return LibraryBooksResponse(data: LibraryBooksData.fromJson(json['data']));
  }
}

class LibraryBooksData {
  final int currentPage;
  final List<Book> data;

  LibraryBooksData({required this.currentPage, required this.data});

  factory LibraryBooksData.fromJson(Map<String, dynamic> json) {
    return LibraryBooksData(
      currentPage: json['current_page'],
      data: List<Book>.from(json['data'].map((x) => Book.fromJson(x))),
    );
  }
}
