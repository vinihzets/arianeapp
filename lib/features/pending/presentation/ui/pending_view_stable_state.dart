import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:flutter/material.dart';

class PendingViewStableData extends StatefulWidget {
  final PendingBloc bloc;
  final BlocState state;

  const PendingViewStableData({
    required this.bloc,
    required this.state,
    super.key,
  });

  @override
  State<PendingViewStableData> createState() => _PendingViewStableDataState();
}

class _PendingViewStableDataState extends State<PendingViewStableData> {
  late ScrollController scrollController;
  PendingStableData get data => widget.state.data;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScrollEvent() {
    bool isOnBottomOfScrollList =
        scrollController.offset >= scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange;

    if (isOnBottomOfScrollList && !data.reachMax) {
      widget.bloc.dispatchEvent(
          PendingEventLoadMore(cache: data.pendings, date: data.date));
    }
  }

  onSearchPressed() async {
    final result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (result == null) {
      return;
    }

    widget.bloc.dispatchEvent(PendingEventOnReady(result));
  }

  @override
  Widget build(BuildContext context) {
    final pendings = data.pendings;
    return Column(
      children: [
        TextButton(
            onPressed: () {
              onSearchPressed();
            },
            child: const Text('Pesquisar pendencias por data')),
        Expanded(
          child: Center(
            child: ListView.separated(
              controller: scrollController,
              itemCount: pendings.length + 1,
              itemBuilder: (context, index) {
                if (index == pendings.length) {
                  return Center(
                    child: data.reachMax
                        ? const Text('Isso é tudo!')
                        : const CircularProgressIndicator.adaptive(),
                  );
                }
                return _buildItem(pendings[index]);
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(PendingEntity item) {
    return ListTile(
      title: Text(item.clientName),
      subtitle: Text(item.message),
      trailing: item.sent
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.schedule,
              color: Colors.orange,
            ),
    );
  }
}
