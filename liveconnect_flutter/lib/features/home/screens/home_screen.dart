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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedTopic = 'all';
  List<LiveStream> _liveStreams = [];
  bool _isLoading = true;
  AppException? _error;

  @override
  void initState() {
    super.initState();
    _loadStreams();
  }

  Future<void> _loadStreams() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final streams = await MockDataService.getLiveStreams(
        category: _selectedTopic == 'all' ? null : _selectedTopic,
      );
      setState(() {
        _liveStreams = streams;
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

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.key != widget.key) {
      _loadStreams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Topics selector
            _buildTopicsSelector(),
            
                  // Live streams grid
                  Expanded(
                    child: _buildContent(),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'LiveConnect',
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textPrimary),
                onPressed: () {},
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                    onPressed: () => context.push('/notifications'),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryPink,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopicsSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: AvailableTopics.topics.map((topic) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TopicChip(
                label: topic.label,
                icon: topic.icon,
                isSelected: _selectedTopic == topic.id,
                onTap: () {
                  setState(() {
                    _selectedTopic = topic.id;
                  });
                  _loadStreams();
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const LoadingWidget(message: 'Loading streams...');
    }

    if (_error != null) {
      return ErrorDisplay(
        error: _error!,
        onRetry: _loadStreams,
        title: 'Failed to load streams',
      );
    }

    if (_liveStreams.isEmpty) {
      return EmptyState(
        title: 'No streams available',
        message: 'Check back later for live streams',
        icon: Icons.videocam_off,
      );
    }

    return _buildStreamsGrid();
  }

  Widget _buildStreamsGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _liveStreams.length,
        itemBuilder: (context, index) {
          return LiveCard(stream: _liveStreams[index]);
        },
      ),
    );
  }
}

