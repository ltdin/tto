import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/models/thread_model.dart';
import 'package:news/pages/thread/thread_detail_page.dart';

import '../../blocs/news_bloc.dart';
import '../app_loading.dart';

/// 🌟 Widget hiển thị danh sách thread chạy tự động.
/// - [reverse] = false 👉 chạy từ trái → phải
/// - [reverse] = true  👉 chạy từ phải → trái
class ThreadNameSlider extends StatefulWidget {
  final List<ThreadModel> threads;
  final bool reverse; // 👈 Đảo chiều chạy

  const ThreadNameSlider({
    Key key,
    @required this.threads,
    this.reverse = false, // Mặc định chạy trái → phải
  }) : super(key: key);

  @override
  State<ThreadNameSlider> createState() => _ThreadNameSliderState();
}

class _ThreadNameSliderState extends State<ThreadNameSlider> {
  final ScrollController _scrollController = ScrollController();
  final List<double> _itemWidths = [];
  int _currentIndex = 0;
  Timer _timer;
  bool _isUserDragging = false;
  double _lastOffset = 0;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateItemWidths();
      if (widget.reverse) {
        _currentIndex = widget.threads.length - 1; // bắt đầu từ phải
      }
      // _scrollController.addListener(_onScrollChanged); // ✅ thêm dòng này
      _scrollController.addListener(() {
        if (_scrollController.position.isScrollingNotifier.value) {
          _isUserDragging = true;
        }
      });
      _scrollController.position.isScrollingNotifier.addListener(() {
        if (!_scrollController.position.isScrollingNotifier.value) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _isUserDragging = false;
          });
        }
      });

      _startStepScrolling();
    });
  }

  //user scroll và tự bật lại auto scroll
  void _onScrollChanged() {
    if ((_scrollController.offset - _lastOffset).abs() > 2.0) {
      _isUserDragging = true;

      // Nếu user ngừng kéo -> 1 giây sau chạy lại auto-scroll
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!_scrollController.position.isScrollingNotifier.value) {
          _isUserDragging = false;
        }
      });
    }
    _lastOffset = _scrollController.offset;
  }

  void _calculateItemWidths() {
    _itemWidths.clear();
    for (final thread in widget.threads) {
      final tp = TextPainter(
        text: TextSpan(text: thread.name, style: const TextStyle(fontSize: 14)),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      _itemWidths.add(tp.width + 24);
    }
  }

  // void _startStepScrolling() {
  //   _timer = Timer.periodic(const Duration(milliseconds: 1200), (_) {
  //     if (!mounted || _itemWidths.isEmpty || !_scrollController.hasClients) return;
  //
  //     double offset = 0;
  //     for (int i = 0; i < _currentIndex; i++) {
  //       offset += _itemWidths[i] + 12;
  //     }
  //
  //     double targetOffset;
  //     if (widget.reverse) {
  //       // 👉 Khi reverse, tính offset từ phải sang trái
  //       targetOffset = _scrollController.position.maxScrollExtent - offset;
  //     } else {
  //       // 👉 Bình thường: trái sang phải
  //       targetOffset = offset;
  //     }
  //
  //     _scrollController.animateTo(
  //       targetOffset.clamp(
  //         _scrollController.position.minScrollExtent,
  //         _scrollController.position.maxScrollExtent,
  //       ),
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //
  //     // 🔁 Di chuyển chỉ số theo hướng phù hợp
  //     if (widget.reverse) {
  //       _currentIndex--;
  //       if (_currentIndex < 0) {
  //         _currentIndex = widget.threads.length - 1;
  //       }
  //     } else {
  //       _currentIndex++;
  //       if (_currentIndex >= widget.threads.length) {
  //         _currentIndex = 0;
  //       }
  //     }
  //   });
  // }


  void _startStepScrolling() {
    const speed = 1; // tốc độ cuộn (px mỗi tick)

    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!mounted || !_scrollController.hasClients) return;
      if (_isUserDragging) return;
      final maxExtent = _scrollController.position.maxScrollExtent;
      double nextOffset = _scrollController.offset + speed;

      if (nextOffset >= maxExtent) {
        // Reset về nửa đầu
        nextOffset = nextOffset - maxExtent;
        _scrollController.jumpTo(nextOffset);
      } else {
        _scrollController.jumpTo(nextOffset);
      }
    });
  }


  // String _shortenName(String name) {
  //   if (name == null) return '';
  //   if (name.length > 20) return name.substring(0, 20) + '...';
  //   return name;
  // }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.threads == null || widget.threads.isEmpty) return const SizedBox();

    return SizedBox(
      height: 45,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        reverse: widget.reverse, // đảo hướng hiển thị
        itemCount: widget.threads.length*2,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        physics: const BouncingScrollPhysics(),

        itemBuilder: (context, index) {
          // final thread = widget.threads[index];
          final realIndex = index % widget.threads.length;
          final thread = widget.threads[realIndex];

          return GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: AppLoadingIndicator()),
              );

              try {
                final fullThreadList = await bloc.getThreads(
                  pageIndex: 1,
                  threadId: thread.id,
                );

                Navigator.pop(context);

                if (fullThreadList.isNotEmpty) {
                  final fullThread = fullThreadList.first;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ThreadDetailPage(thread: fullThread),
                    ),
                  );
                }
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Không thể tải chủ đề: $e')),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(
                child: Text(
                  thread.name,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                  softWrap: true, // 👈 cho phép xuống dòng
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}

class ThreadSlidersGroup extends StatefulWidget {
  const ThreadSlidersGroup({Key key}) : super(key: key);

  @override
  State<ThreadSlidersGroup> createState() => _ThreadSlidersGroupState();
}

class _ThreadSlidersGroupState extends State<ThreadSlidersGroup> {
  Future<List<ThreadModel>> _loadAllThreads() async {
    List<ThreadModel> allThreads = [];

    // 🧩 Giả sử bạn có khoảng 3 page dữ liệu
    for (int page = 10; page <= 20; page++) {
      final threads = await bloc.getThreads(pageIndex: page);
      allThreads.addAll(threads);
    }

    // 🔁 Gộp và loại bỏ trùng theo id
    final uniqueThreads = <int, ThreadModel>{};
    for (final t in allThreads) {
      uniqueThreads[t.id] = t;
    }

    final merged = uniqueThreads.values.toList();

    // 🧠 Sắp theo DistributionDate mới nhất của mỗi thread
    merged.sort((a, b) {
      final latestA = _getLatestDistributionDate(a);
      final latestB = _getLatestDistributionDate(b);
      return latestB.compareTo(latestA);
    });

    return merged;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThreadModel>>(
      future: _loadAllThreads(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const AppLoadingIndicator();
        final threads = snapshot.data ?? [];
        if (threads.isEmpty) return const SizedBox();

        // final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 180));
        // 📅 Lọc chỉ lấy thread có bài trong 1 tháng gần nhất
        final oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
        final filteredThreads = threads.where((thread) {
          final latestDate = _getLatestDistributionDate(thread);
          return latestDate.isAfter(oneMonthAgo);
        }).toList();


        if (filteredThreads.isEmpty) return const SizedBox();

        // 🧩 Lấy top 10 chủ đề mới nhất sau khi lọc
        final recentThreads = filteredThreads.take(10).toList();

        // 🎲 Chia đôi danh sách cho 2 slider không trùng nhau
        final half = (recentThreads.length / 2).ceil();
        final threads1 = recentThreads.take(half).toList();
        final threads2 = recentThreads.skip(half).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThreadNameSlider(threads: threads1),
            const SizedBox(height: 6),
            ThreadNameSlider(threads: threads2, reverse: true),
          ],
        );
      },
    );
  }

  /// 📅 Lấy DistributionDate mới nhất trong danh sách News của 1 Thread
  DateTime _getLatestDistributionDate(ThreadModel thread) {
    if (thread.news == null || thread.news.isEmpty) return DateTime(1970);
    final dates = thread.news
        .map((n) => DateTime.tryParse(n.distributionDate ?? ''))
        .where((d) => d != null)
        .toList();
    if (dates.isEmpty) return DateTime(1970);
    dates.sort((a, b) => b.compareTo(a));
    return dates.first;
  }
}


/// 🧠 Widget hiển thị 2 slider cùng lúc từ 1 API — dữ liệu không trùng nhau.
// class ThreadSlidersGroup extends StatelessWidget {
//   const ThreadSlidersGroup({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<ThreadModel>>(
//       future: bloc.getThreads(pageIndex: 1), // 🧠 Chỉ gọi 1 API
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const AppLoadingIndicator();
//         final threads = snapshot.data ?? [];
//         if (threads.isEmpty) return const SizedBox();
//
//         // 🎲 Trộn danh sách để tránh trùng
//         // final shuffled = List<ThreadModel>.from(threads)..shuffle();
//         // final half = (shuffled.length / 2).ceil();
//         // final threads1 = shuffled.take(half).toList();
//         // final threads2 = shuffled.skip(half).toList();
//
//         final List<ThreadModel> shuffled = List<ThreadModel>.from(threads)..shuffle(Random());
//         final half = (shuffled.length / 2).floor();
//         final threads1 = shuffled.take(half).toList();
//         final threads2 = shuffled.skip(half).take(half).toList();
//
//         // Nếu danh sách không đủ, nhân đôi dữ liệu để 2 slider bằng nhau
//         while (threads1.length < threads2.length) {
//           threads1.addAll(threads1);
//         }
//         while (threads2.length < threads1.length) {
//           threads2.addAll(threads2);
//         }
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ThreadNameSlider(
//               threads: threads1,
//               reverse: false, // trái → phải
//             ),
//             const SizedBox(height: 6),
//             ThreadNameSlider(
//               threads: threads2,
//               reverse: true, // phải → trái
//             ),
//           ],
//         );
//       },
//     );
//   }
// }