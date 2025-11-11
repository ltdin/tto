import 'package:news/base/app_helpers.dart';
import 'package:news/models/newspaper.dart';

class ListNewspaper {
  final List<Newspaper> list;
  final PaginationModel pagination;

  const ListNewspaper({this.list, this.pagination});

  // Get
  bool get isNotEmplty => list.isNotEmpty;

  factory ListNewspaper.fromJson(Map<String, dynamic> json) => ListNewspaper(
        list: lookup<List>(json, ['list'])
                ?.map<Newspaper>((o) => Newspaper.fromListNewspaperJson(o))
                ?.toList() ??
            <Newspaper>[],
        pagination: PaginationModel.fromJson(json["pagination"]),
      );

  factory ListNewspaper.emplty() =>
      ListNewspaper(list: <Newspaper>[], pagination: PaginationModel.emplty());
}

class PaginationModel {
  const PaginationModel({this.currentPage, this.totalPage, this.total});

  final String currentPage;
  final int totalPage;
  final int total;

  // Get
  int get getIntCurrentPage => int.tryParse(currentPage);
  int get getTotalPage => totalPage;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        currentPage: json["current_page"],
        totalPage: json["total_page"],
        total: json["total"],
      );
  factory PaginationModel.emplty() =>
      PaginationModel(currentPage: '1', totalPage: 0, total: 0);
}
