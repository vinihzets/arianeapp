import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/utils/date_formatter.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
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
  onSearchPressed() async {
    final result = await showDatePicker(
        context: context,
        initialDate: data.date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (result == null) {
      return;
    }

    widget.bloc.dispatchEvent(PendingEventOnReady(date: result));
  }

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
      widget.bloc.dispatchEvent(PendingEventLoadMore(
        cache: data.pendings,
        date: data.date,
        messages: data.messages,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendings = data.pendings;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(DateFormatter.ddMMyyyy(data.date)),
          TextButton(
            onPressed: () => onSearchPressed(),
            child: const Text('Pesquisar pendencias por data'),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.messages.map((e) => _buildItemMessage(e)).toList(),
            ),
          ),
          const Divider(),
          Center(
            child: ListView.separated(
              shrinkWrap: true,
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
        ],
      ),
    );
  }

  Widget _buildItemMessage(SchedulingMessageEntity item) {
    return ListTile(
      leading: item.sent
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.schedule,
              color: Colors.orange,
            ),
      title: Text(item.listClients.map((e) => e.firstName).toList().join(',')),
      subtitle: const Text('Agendamento'),
      trailing: IconButton(
        onPressed: () => widget.bloc.dispatchEvent(
          PendingEventSendMessageToList(context, item, data.date),
        ),
        icon: const Icon(Icons.send),
      ),
    );
  }

  Widget _buildItem(PendingEntity item) {
    return ListTile(
      leading: item.sent
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.schedule,
              color: Colors.orange,
            ),
      title: Text('${item.clientName} (${item.period.name})'),
      subtitle: Text(item.typePerfuration.name),
      trailing: IconButton(
        onPressed: () => widget.bloc.dispatchEvent(
          PendingEventSendMessage(item, data.date),
        ),
        icon: const Icon(Icons.send),
      ),
    );
  }
}
