import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/utils/date_formatter.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_event.dart';
import 'package:flutter/material.dart';

class SchedulingMessageViewStableState extends StatefulWidget {
  final SchedulingMessageBloc bloc;
  final BlocState state;

  const SchedulingMessageViewStableState({
    required this.bloc,
    required this.state,
    super.key,
  });

  @override
  State<SchedulingMessageViewStableState> createState() =>
      _SchedulingMessageViewStableStateState();
}

class _SchedulingMessageViewStableStateState
    extends State<SchedulingMessageViewStableState> {
  late ScrollController scrollController;
  SchedulingMessageStableData get data => widget.state.data;
  int fetchAmmount = 10;

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
      widget.bloc
          .dispatchEvent(SchedulingMessageEventLoadMore(date: DateTime.now()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = data.listMessages;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: ListView.separated(
              controller: scrollController,
              itemCount: messages.length + 1,
              itemBuilder: (context, index) {
                if (index == messages.length) {
                  return Center(
                    child: data.reachMax
                        ? const Text('Isso é tudo!')
                        : const CircularProgressIndicator.adaptive(),
                  );
                }
                return _buildItem(messages[index]);
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(SchedulingMessageEntity item) {
    final normalDate = DateTime.fromMillisecondsSinceEpoch(
      int.parse(item.createdAt),
    );

    return ListTile(
      title: Text(item.message),
      subtitle: Text(DateFormatter.ddMMyyyy(normalDate)),
      trailing: const Icon(Icons.arrow_right),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clientes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: item.listClients
                .map(
                  (e) => ListTile(
                    title: Text(e.firstName),
                    trailing: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => WhatsApp.sendMessage(
                        e.number,
                        item.message,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
