import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../profile/presentation/presentation.dart';
import '../../home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  final int _size = 4;
  String _searchKeyword = '';
  // bool _inStockOnly = false;
  String _sortBy = '';

  @override
  void initState() {
    // Metode ini dipanggil saat widget diinisialisasi.
    super.initState();

    // dipanggil untuk memuat data awal.
    _scrollController.addListener(_onScroll);
    _loadInitialDrugs();
  }

  // dipanggil saat widget akan dihancurkan atau dihapus dari widget tree.
  // Ini berguna untuk membersihkan resource agar tidak terjadi kebocoran memori.
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // memeriksa apakah data telah dimuat (DrugLoaded)?.
  // Jika belum, fungsi ini akan mengatur halaman (_page) ke 1
  // dan memicu event LoadDrugsEvent.
  void _loadInitialDrugs() {
    final state = context.read<DrugBloc>().state;
    if (state is! DrugLoaded || state.drugs.isEmpty) {
      _page = 1;
      context.read<DrugBloc>().add(LoadDrugsEvent(_page, _size));
    }
  }

  // dipanggil setiap kali pengguna menggulirkan layar.
  // Jika posisi scroll mencapai bagian bawah, ia akan memuat lebih banyak data.
  void _onScroll() {
    if (_isBottom) {
      final state = context.read<DrugBloc>().state;
      if (state is DrugLoaded && !state.hasReachedMax) {
        setState(() {
          _page++;
        });
        context
            .read<DrugBloc>()
            .add(LoadDrugsEvent(_page, _size, search: _searchKeyword));
      }
    }
  }

  // Memeriksa apakah posisi scroll sudah mencapai bagian bawah.
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll - 200);
  }

  // memicu pencarian berdasarkan kata kunci dan mengatur ulang halaman ke 1.
  void _onSearch(String keyword) {
    setState(() {
      _searchKeyword = keyword;
      _page = 1;
    });
    context.read<DrugBloc>().add(SearchDrugsEvent(keyword, _size));
  }

  // void _onFilter(bool inStockOnly) {
  //   setState(() {
  //     _inStockOnly = inStockOnly;
  //   });
  //   context.read<DrugBloc>().add(FilterDrugsEvent(inStockOnly));
  // }

  //  memicu pengurutan berdasarkan parameter yang dipilih.
  void _onSort(String sortBy) {
    setState(() {
      _sortBy = sortBy;
    });
    context.read<DrugBloc>().add(SortDrugsEvent(sortBy));
  }

  void _showFilterSortDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Filter by stock:'),
                  //     Switch(
                  //       value: _inStockOnly,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _inStockOnly = value;
                  //         });
                  //         _onFilter(value);
                  //       },
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sort by:'),
                      DropdownButton<String>(
                        value: _sortBy,
                        items: <DropdownMenuItem<String>>[
                          const DropdownMenuItem(
                              value: '', child: Text('None')),
                          const DropdownMenuItem(
                              value: 'name', child: const Text('Name A-Z')),
                          const DropdownMenuItem(
                              value: 'name_desc', child: Text('Name Z-A')),
                          const DropdownMenuItem(
                              value: 'stock',
                              child: Text('Stock (most to least)')),
                          const DropdownMenuItem(
                              value: 'stock_asc',
                              child: Text('Stock (least to most)')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _sortBy = value!;
                          });
                          _onSort(value!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildTopSection(screenWidth, topPadding, context),
          ),
          BlocBuilder<DrugBloc, DrugState>(
            builder: (context, state) {
              if (state is DrugLoading && state.drugs.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is DrugLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= state.drugs.length) {
                        return BottomLoader();
                      } else {
                        return DrugListCard(drug: state.drugs[index]);
                      }
                    },
                    childCount: state.hasReachedMax
                        ? state.drugs.length
                        : state.drugs.length + 1,
                  ),
                );
              } else if (state is DrugError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(state.message)),
                );
              }
              return const SliverToBoxAdapter(
                child: Center(child: Text('No drugs loaded.')),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterSortDialog,
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  Widget _buildTopSection(
      double screenWidth, double topPadding, BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String userName = 'User';
        if (state is ProfileLoaded) {
          userName = state.user.userData.fullName;
        }

        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: topPadding + 16),
          decoration: BoxDecoration(
            color: Colors
                .blue[800], // blue colors for top section (welcome & cart)
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Welcome, $userName',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // white color for welcome text
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: Colors.white, // white color for Cart Icons
                      size: 28,
                    ),
                    onPressed: () async {
                      final userId =
                          await SharedPreferencesHelper().getUserId();
                      if (userId != null) {
                        Navigator.pushNamed(context, '/cart');
                      } else {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white, // white color for search drugs field
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  onSubmitted: _onSearch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search drugs...',
                    prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                    hintStyle: TextStyle(color: Colors.blueGrey[300]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
