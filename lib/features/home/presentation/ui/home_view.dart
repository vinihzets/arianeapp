import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../clients/clients.dart';
import '../../../pending/presentation/ui/pending_view.dart';
import '../../home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc bloc;
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    bloc = GetIt.I.get();
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: const [
          ClientView(),
          PendingView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Pendentes',
          ),
        ],
      ),
    );
  }
}
