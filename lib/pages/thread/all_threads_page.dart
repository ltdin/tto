import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/thread_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/thread/thread_detail_page.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:news/widgets/appbar_for_tab.dart';
import '../../blocs/news_bloc.dart';

class AllThreadsPage extends StatefulWidget {
  const AllThreadsPage({Key key}) : super(key: key);

  @override
  State<AllThreadsPage> createState() => _AllThreadsPageState();
}

class _AllThreadsPageState extends State<AllThreadsPage> {
  List<ThreadModel> allThreads = [];
  List<ThreadModel> filteredThreads = [];
  List<ZoneList> zones = [];
  String searchKeyword = '';
  ZoneList selectedZone;
  bool showFullView = true;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchZones();
    _scrollController.addListener(_onScroll);
  }

  void _resetToInitialThreads() {
    setState(() {
      selectedZone = zones.first;
      searchKeyword = '';
      currentPage = 1;
      hasMore = true;
    });
    _fetchThreads(); // Gọi lại API mặc định
  }


  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _fetchThreads(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchThreads({bool isLoadMore = false}) async {
    if (isLoading || (!hasMore && isLoadMore)) return;
    isLoading = true;

    final nextPage = isLoadMore ? currentPage + 1 : 1;

    try {
      final threads = await bloc.getThreads(
        pageIndex: nextPage,
        zoneId: selectedZone?.name == 'Chuyên mục' ? null : selectedZone?.zoneId,
        keyword: searchKeyword.trim(),
      );

      setState(() {
        if (isLoadMore) {
          allThreads.addAll(threads);
          currentPage = nextPage;
        } else {
          allThreads = threads;
          currentPage = 1;
        }

        hasMore = threads.length >= 10;
        filteredThreads = allThreads;
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> _fetchZones() async {
    try {
      final res = await bloc.fetchZoneList();
      final Set<int> existingZoneIds = res.map((z) => z.zoneId).toSet();

      final List<ZoneList> mergedZones = [
        ZoneList(name: 'Chuyên mục'),
        ...KString.cates.where((cate) => !existingZoneIds.contains(cate.zoneId)),
        if (!existingZoneIds.contains(200071))
          ZoneList(zoneId: 200071, name: "Tuổi trẻ cuối tuần"),
        ...res,
      ];

      if (mounted) {
        setState(() {
          zones = mergedZones;
          if (selectedZone == null || !zones.contains(selectedZone)) {
            selectedZone = zones.first;
          }
        });
      }

      await _fetchThreads();
    } catch (e) {
      debugPrint('Error fetching zones: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: 'Chủ đề nổi bật'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Column(
              children: [
                TextField(
                  // onChanged: (value) async {
                  //   searchKeyword = value;
                  //   await _fetchThreads();
                  // },
                  // onChanged: (value) async {
                  //   searchKeyword = value;
                  //   if (value.trim().isEmpty) {
                  //     _resetToInitialThreads(); // reset zone + keyword + gọi lại API
                  //   } else {
                  //     await _fetchThreads(); // tìm kiếm theo keyword
                  //   }
                  // },
                  onChanged: (value) async {
                    if (value.trim().isEmpty) {
                      // Reset về mặc định: zone đầu tiên và search rỗng
                      setState(() {
                        selectedZone = zones.first;
                        searchKeyword = '';
                      });
                    } else {
                      searchKeyword = value;
                    }
                    await _fetchThreads();
                  },

                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm chủ đề',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                SizedBox(height: 8),
                zones.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: DropdownButton<ZoneList>(
                              isExpanded: true,
                              value: zones.contains(selectedZone) ? selectedZone : zones.first,
                              onChanged: (zone) async {
                                setState(() {
                                  selectedZone = zone;
                                });
                                await _fetchThreads();
                              },
                              items: zones.map((zone) {
                                return DropdownMenuItem<ZoneList>(
                                  value: zone,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width - 96,
                                    child: Text(
                                      zone.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showFullView = !showFullView;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          showFullView ? Icons.grid_view : Icons.list,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredThreads.isEmpty
                ? Center(child: Text(KString.msgNoData))
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(paddingNews),
              itemCount: filteredThreads.length,
              itemBuilder: (context, index) {
                final thread = filteredThreads[index];
                final avatar = thread.coverImage;
                final previewArticles = thread.articles.take(3).toList();

                return InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => Center(child: AppLoadingIndicator()),
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
                        ).then((_) {
                          _resetToInitialThreads();
                        });
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Không thể tải chủ đề: $e')),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                thread.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                        if (showFullView) ...[
                          SizedBox(height: 8),
                          if (avatar?.isNotEmpty ?? false)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                avatar,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
                              ),
                            ),
                          SizedBox(height: 8),
                          ...previewArticles.map(
                                (a) => Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text('• ${a.title}', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
