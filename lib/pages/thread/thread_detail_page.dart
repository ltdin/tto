// import 'package:flutter/material.dart';
// import 'package:news/constant/length.dart';
// import 'package:news/constant/string.dart';
// import 'package:news/models/article_model.dart';
// import 'package:news/models/thread_model.dart';
// import 'package:news/widgets/app_loading.dart';
// import 'package:news/widgets/appbar_for_tab.dart';
// import 'package:news/widgets/large_news/large_news_type_2.dart';
//
// class ThreadDetailPage extends StatefulWidget {
//   final ThreadModel thread;
//
//   const ThreadDetailPage({Key key, @required this.thread}) : super(key: key);
//
//   @override
//   State<ThreadDetailPage> createState() => _ThreadDetailPageState();
// }
//
// class _ThreadDetailPageState extends State<ThreadDetailPage> {
//   List<Article> articles;
//
//   @override
//   void initState() {
//     super.initState();
//     // Lấy toàn bộ bài viết của thread
//     articles = widget.thread.articles ?? [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWidget(title: widget.thread.name, ),
//       body: articles.isEmpty
//           ? Center(child: Text(KString.msgNoData))
//           : ListView.separated(
//         padding: const EdgeInsets.all(paddingNews),
//         itemCount: articles.length,
//         separatorBuilder: (_, __) => SizedBox(height: paddingNews),
//         itemBuilder: (context, index) => LargeNewsType2(
//           article: articles[index],
//           isShowDivider: index != 0,
//           isSolid: true,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/thread_model.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import 'package:news/widgets/large_news/large_news_type_2.dart';

import '../../widgets/divider_widget.dart';

class ThreadDetailPage extends StatefulWidget {
  final ThreadModel thread;

  const ThreadDetailPage({Key key, @required this.thread}) : super(key: key);

  @override
  State<ThreadDetailPage> createState() => _ThreadDetailPageState();
}

class _ThreadDetailPageState extends State<ThreadDetailPage> {
  List<Article> articles = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    articles = widget.thread.articles ?? [];
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 &&
        !isLoading &&
        hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => isLoading = true);
    final nextPage = currentPage + 1;

    try {
      final threads =
      await bloc.getThreadDetail(widget.thread.id, nextPage);
      if (threads.isNotEmpty) {
        final fetchedThread = threads.firstWhere(
                (t) => t.id == widget.thread.id,
            orElse: null);

        if (fetchedThread != null && fetchedThread.articles?.isNotEmpty == true) {
          setState(() {
            currentPage = nextPage;
            articles.addAll(fetchedThread.articles);
          });
        } else {
          setState(() => hasMore = false);
        }
      } else {
        setState(() => hasMore = false);
      }
    } catch (e) {
      debugPrint('Load more error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: widget.thread.name),
      body: articles.isEmpty
          ? Center(child: Text(KString.msgNoData))
          :
      ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(paddingNews),
        itemCount: articles.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == articles.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppLoadingIndicator(),
              ),
            );
          }

          final article = articles[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index != 0) DividerWidget(isSolid: true, color: Colors.grey),
              LargeNewsType2(
                article: article,
                isSolid: true,
              ),
            ],
          );
        },
      )

    );
  }
}
