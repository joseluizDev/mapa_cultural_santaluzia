import 'package:flutter/material.dart';

import '../../core/state/value_store.dart';
import '../../domain/entities/talent.dart';
import '../../domain/usecases/get_all_talents_usecase.dart';
import '../../domain/usecases/search_talents_usecase.dart';
import '../stores/talent_value_store.dart';

class TalentsListPage extends StatefulWidget {
  final GetAllTalentsUseCase getAllTalentsUseCase;
  final SearchTalentsUseCase searchTalentsUseCase;

  const TalentsListPage({
    super.key,
    required this.getAllTalentsUseCase,
    required this.searchTalentsUseCase,
  });

  @override
  State<TalentsListPage> createState() => _TalentsListPageState();
}

class _TalentsListPageState extends State<TalentsListPage> {
  late final TalentValueStore _store;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize store with required use cases
    _store = TalentValueStore(
      getAllTalentsUseCase: widget.getAllTalentsUseCase,
      searchTalentsUseCase: widget.searchTalentsUseCase,
    );

    // Load initial data
    _store.loadAllTalents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _store.loadAllTalents(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search talents...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _store.loadAllTalents();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) => _store.searchByName(value),
            ),
          ),

          // Talent list with state management
          Expanded(
            child: StoreConsumer<List<Talent>>(
              store: _store,
              // Success state - show the list of talents
              builder: (context, talents) {
                return ListView.builder(
                  itemCount: talents.length,
                  itemBuilder: (context, index) {
                    final talent = talents[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(talent.imagemUrl),
                        child: talent.imagemUrl.isEmpty
                            ? Text(talent.nome[0])
                            : null,
                      ),
                      title: Text(talent.nome),
                      subtitle: Text(talent.habilidades.join(', ')),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigate to talent details
                      },
                    );
                  },
                );
              },
              // Loading state - show a progress indicator
              loadingBuilder: (context) => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading talents...'),
                  ],
                ),
              ),
              // Error state - show error message
              errorBuilder: (context, message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _store.loadAllTalents(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
              // Empty state - show empty message
              emptyBuilder: (context, message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_search,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message ?? 'No talents found',
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _store.loadAllTalents(),
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Filter button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show filter dialog
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
