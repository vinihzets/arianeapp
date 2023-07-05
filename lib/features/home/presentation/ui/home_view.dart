import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/drawer/custom_drawer.dart';
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
      drawer: const CustomDrawer(),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => bloc.dispatchEvent(HomeEventSignOut(context)),
              child: const Text(
                'Sair',
              ))
        ],
      ),
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p) {
            pageController.animateToPage(p,
                duration: const Duration(seconds: 1), curve: Curves.ease);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notificações',
            ),
          ]),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (p) {
          setState(() {
            _page = p;
          });
        },
        children: const [
          ClientView(),
          PendingView(),
        ],
      ),
    );
  }
}
