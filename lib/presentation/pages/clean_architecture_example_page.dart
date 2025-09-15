import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/talent.dart';
import '../../domain/usecases/get_all_talents_usecase.dart';
import '../../domain/usecases/search_talents_usecase.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/talent_card.dart';

/// Example page demonstrating Clean Architecture implementation
/// Shows how to use dependency injection and use cases properly
class CleanArchitectureExamplePage extends StatefulWidget {
  const CleanArchitectureExamplePage({super.key});

  @override
  State<CleanArchitectureExamplePage> createState() =>
      _CleanArchitectureExamplePageState();
}

class _CleanArchitectureExamplePageState
    extends State<CleanArchitectureExamplePage> {
  // Use cases injected via service locator
  late final GetAllTalentsUseCase _getAllTalentsUseCase;
  late final SearchTalentsUseCase _searchTalentsUseCase;

  // State management
  List<Talent> _talents = [];
  List<Talent> _filteredTalents = [];
  bool _isLoading = false;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize use cases via dependency injection
    _getAllTalentsUseCase = getAllTalentsUseCase;
    _searchTalentsUseCase = searchTalentsUseCase;

    // Load initial data
    _loadTalents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Loads all talents using the use case
  /// Demonstrates proper error handling and loading states
  Future<void> _loadTalents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Use case call - encapsulates business logic
      final talents = await _getAllTalentsUseCase.execute();

      setState(() {
        _talents = talents;
        _filteredTalents = talents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  /// Searches talents using the search use case
  /// Demonstrates how to use use cases with parameters
  Future<void> _searchTalents(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _filteredTalents = _talents;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Use case call with parameters
      final results = await _searchTalentsUseCase.execute(query: query);

      setState(() {
        _filteredTalents = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  /// Searches by skills - demonstrates different search criteria
  Future<void> _searchBySkills(List<String> skills) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await _searchTalentsUseCase.execute(skills: skills);

      setState(() {
        _filteredTalents = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentPage: AppPage.home,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          _buildSearchSection(),
          _buildSkillsFilterSection(),
          _buildContentSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.largeSpacing),
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Column(
          children: [
            const Text(
              'Clean Architecture Example',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.smallSpacing),
            const Text(
              'Demonstrating proper use of Use Cases and Dependency Injection',
              style: TextStyle(fontSize: 16, color: AppColors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.mediumSpacing),
            Text(
              'Total Talents: ${_talents.length} | Filtered: ${_filteredTalents.length}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.largeSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Talents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: AppDimensions.smallSpacing),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.mediumBorderRadius,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.mediumSpacing,
                        vertical: AppDimensions.smallSpacing,
                      ),
                    ),
                    onChanged: _searchTalents,
                  ),
                ),
                const SizedBox(width: AppDimensions.smallSpacing),
                ElevatedButton(
                  onPressed: () {
                    _searchController.clear();
                    _loadTalents();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.culturalRed,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.all(AppDimensions.mediumSpacing),
                  ),
                  child: const Icon(Icons.clear),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsFilterSection() {
    final commonSkills = [
      'Fotografia',
      'Design',
      'Música',
      'Desenvolvimento',
      'Marketing',
      'Culinária',
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.largeSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter by Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: AppDimensions.smallSpacing),
            Wrap(
              spacing: AppDimensions.smallSpacing,
              runSpacing: AppDimensions.smallSpacing,
              children: commonSkills.map((skill) {
                return ElevatedButton(
                  onPressed: () => _searchBySkills([skill]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.culturalBlue,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.mediumSpacing,
                      vertical: AppDimensions.smallSpacing,
                    ),
                  ),
                  child: Text(skill),
                );
              }).toList(),
            ),
            const SizedBox(height: AppDimensions.largeSpacing),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    if (_isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.extraLargeSpacing),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.extraLargeSpacing),
            child: Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.culturalRed,
                ),
                const SizedBox(height: AppDimensions.mediumSpacing),
                Text(
                  'Error: $_errorMessage',
                  style: const TextStyle(
                    color: AppColors.culturalRed,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.mediumSpacing),
                ElevatedButton(
                  onPressed: _loadTalents,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.culturalRed,
                    foregroundColor: AppColors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.mediumSpacing,
          mainAxisSpacing: AppDimensions.mediumSpacing,
          childAspectRatio: 1.2,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final talent = _filteredTalents[index];
          return TalentCard(
            talento: talent,
            onTap: () {
              GoRouter.of(
                context,
              ).goNamed('talent_detail', pathParameters: {'name': talent.nome});
            },
          );
        }, childCount: _filteredTalents.length),
      ),
    );
  }
}
