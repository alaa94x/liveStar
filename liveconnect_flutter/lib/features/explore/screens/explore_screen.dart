import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/live_card.dart';
import '../../../core/widgets/topic_chip.dart';
import '../../../core/widgets/error_widgets.dart';
import '../../../core/models/live_stream_model.dart';
import '../../../core/models/topic_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data_service.dart';
import '../../../core/errors/app_exceptions.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'all';
  List<LiveStream> _trendingStreams = [];
  List<LiveStream> _categoryStreams = [];
  bool _isLoading = true;
  AppException? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final allStreams = await MockDataService.getLiveStreams();
      final categoryStreams = await MockDataService.getLiveStreams(
        category: _selectedCategory == 'all' ? null : _selectedCategory,
      );
      setState(() {
        _trendingStreams = allStreams..sort((a, b) => b.viewerCount.compareTo(a.viewerCount));
        _trendingStreams = _trendingStreams.take(6).toList();
        _categoryStreams = categoryStreams;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e is AppException
            ? e
            : const UnknownException('Failed to load streams');
        _isLoading = false;
      });
    }
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: LoadingWidget(message: 'Loading explore...'),
        bottomNavigationBar: BottomNavBar(),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: ErrorDisplay(
          error: _error!,
          onRetry: _loadData,
          title: 'Failed to load explore',
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trending Section
                    _buildTrendingSection(_trendingStreams),

                    const SizedBox(height: 24),

                    // Categories Selector
                    _buildCategoriesSelector(),

                    const SizedBox(height: 16),

                    // Category Streams
                    _buildCategoryStreams(_categoryStreams),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Explore',
            style: AppTextStyles.displaySmall,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.person_add, color: AppColors.textPrimary),
            onPressed: () => context.push('/discover'),
            tooltip: 'Discover People',
          ),
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection(List<LiveStream> streams) {
    if (streams.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Now 🔥',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: streams.length,
              itemBuilder: (context, index) {
                final stream = streams[index];
                return Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 12),
                  child: LiveCard(stream: stream),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: AvailableTopics.topics.map((topic) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TopicChip(
              label: topic.label,
              icon: topic.icon,
              isSelected: _selectedCategory == topic.id,
              onTap: () => _onCategoryChanged(topic.id),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryStreams(List<LiveStream> streams) {
    if (streams.isEmpty) {
      return EmptyState(
        title: 'No streams in this category',
        message: 'Try selecting a different category',
        icon: Icons.videocam_off,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: streams.length,
        itemBuilder: (context, index) {
          return LiveCard(stream: streams[index]);
        },
      ),
    );
  }
}
