import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../clients/clients.dart';
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
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => bloc.dispatchEvent(HomeEventSignOut(context)),
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.white),
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
                icon: Icon(Icons.person_2_outlined), label: 'Clientes'),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Tipos Perfurações',
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
        TypePerfurationView()],
      ),
    );
  }
}
