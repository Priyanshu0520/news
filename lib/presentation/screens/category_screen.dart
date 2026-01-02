import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news/presentation/state/category_state.dart';
import 'package:news/presentation/widgets/news_card.dart';
import 'package:news/presentation/widgets/filter_widgets.dart';
import 'package:news/presentation/screens/news_detail_screen.dart';
import 'package:news/core/theme/app_theme.dart';

class CategoryScreen extends StatefulWidget {
  final String query;

  const CategoryScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _selectedSort = 'publishedAt';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryState>().loadNewsByCategory(widget.query);
    });
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'business':
        return Icons.business_center;
      case 'sports':
        return Icons.sports_soccer;
      case 'technology':
        return Icons.computer;
      case 'entertainment':
        return Icons.movie;
      case 'health':
        return Icons.favorite;
      case 'politics':
        return Icons.account_balance;
      case 'top news':
        return Icons.trending_up;
      default:
        return Icons.article;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildFilterSection(),
          _buildContent(),
        ],
      ),
      floatingActionButton: _buildSortButton(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 220,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA),
              const Color(0xFF764BA2),
              const Color(0xFFF093FB),
              const Color(0xFFF5576C),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 70, bottom: 20),
          title: Text(
            widget.query,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black26,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          background: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.15,
                  child: Icon(
                    _getCategoryIcon(widget.query),
                    size: 180,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF667EEA),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.filter_list,
                      color: AppTheme.primaryColor, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Filter By',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  NewsFilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onTap: () => setState(() => _selectedFilter = 'All'),
                    icon: Icons.grid_view,
                  ),
                  NewsFilterChip(
                    label: 'Today',
                    isSelected: _selectedFilter == 'Today',
                    onTap: () => setState(() => _selectedFilter = 'Today'),
                    icon: Icons.today,
                  ),
                  NewsFilterChip(
                    label: 'This Week',
                    isSelected: _selectedFilter == 'Week',
                    onTap: () => setState(() => _selectedFilter = 'Week'),
                    icon: Icons.date_range,
                  ),
                  NewsFilterChip(
                    label: 'Trending',
                    isSelected: _selectedFilter == 'Trending',
                    onTap: () => setState(() => _selectedFilter = 'Trending'),
                    icon: Icons.trending_up,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButton() {
    return FloatingActionButton.extended(
      onPressed: _showSortOptions,
      backgroundColor: AppTheme.primaryColor,
      icon: const Icon(Icons.sort),
      label: const Text('Sort'),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SortOption(
              label: 'Latest First',
              icon: Icons.access_time,
              isSelected: _selectedSort == 'publishedAt',
              onTap: () {
                setState(() => _selectedSort = 'publishedAt');
                Navigator.pop(context);
              },
            ),
            SortOption(
              label: 'Most Popular',
              icon: Icons.trending_up,
              isSelected: _selectedSort == 'popularity',
              onTap: () {
                setState(() => _selectedSort = 'popularity');
                Navigator.pop(context);
              },
            ),
            SortOption(
              label: 'Most Relevant',
              icon: Icons.stars,
              isSelected: _selectedSort == 'relevancy',
              onTap: () {
                setState(() => _selectedSort = 'relevancy');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SliverToBoxAdapter(
      child: Consumer<CategoryState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading ${widget.query}...',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.errorMessage != null) {
            return _buildErrorState(state);
          }

          if (state.newsList.isEmpty) {
            return _buildEmptyState();
          }

          return _buildNewsList(state);
        },
      ),
    );
  }

  Widget _buildErrorState(CategoryState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: AppTheme.accentColor,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              state.errorMessage!,
              style: const TextStyle(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CategoryState>().loadNewsByCategory(widget.query);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            const Text(
              'No news found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Try searching for something else',
              style: TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList(CategoryState state) {
    final filteredNews = _getFilteredNews(state.newsList);
    final sortedNews = _getSortedNews(filteredNews);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${sortedNews.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Articles Found',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sortedNews.length,
          itemBuilder: (context, index) {
            return NewsCard(
              article: sortedNews[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsDetailScreen(article: sortedNews[index]),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  List _getFilteredNews(List news) {
    if (_selectedFilter == 'All') return news;

    final now = DateTime.now();
    return news.where((article) {
      final publishedDate = article.publishedAt;
      if (publishedDate == null) return true;

      switch (_selectedFilter) {
        case 'Today':
          return publishedDate.year == now.year &&
              publishedDate.month == now.month &&
              publishedDate.day == now.day;
        case 'Week':
          final weekAgo = now.subtract(const Duration(days: 7));
          return publishedDate.isAfter(weekAgo);
        case 'Trending':
          // Simple heuristic: articles with images are more likely to be trending
          return article.urlToImage != null && article.urlToImage!.isNotEmpty;
        default:
          return true;
      }
    }).toList();
  }

  List _getSortedNews(List news) {
    final sorted = List.from(news);

    switch (_selectedSort) {
      case 'publishedAt':
        sorted.sort((a, b) {
          if (a.publishedAt == null) return 1;
          if (b.publishedAt == null) return -1;
          return b.publishedAt!.compareTo(a.publishedAt!);
        });
        break;
      case 'popularity':
        // Sort by source name (more popular sources first)
        sorted.sort(
            (a, b) => (a.source?.name ?? '').compareTo(b.source?.name ?? ''));
        break;
      case 'relevancy':
        // Already sorted by relevancy from API
        break;
    }

    return sorted;
  }
}
