import 'package:ariane_app/features/pending/pending.dart';
import 'package:ariane_app/features/scheduling_message/presentation/ui/scheduling_message_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/drawer/presentation/ui/custom_drawer.dart';
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
      drawer: const CustomDrawer(),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        actions: [
          TextButton(
            onPressed: () => bloc.dispatchEvent(HomeEventSignOut(context)),
            child: const Text('Sair'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _page,
        children: const [
          ClientView(),
          PendingView(),
          SchedulingMessageView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        showUnselectedLabels: true,
        showSelectedLabels: true,
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
            icon: Icon(Icons.pending_actions),
            label: 'Pendencias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Mensagens',
          ),
        ],
      ),
    );
  }
}
