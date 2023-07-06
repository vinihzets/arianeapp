import 'dart:developer';

import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/clients/presentation/widgets/list_view_client_tile.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  ClientDataSources clientDataSources;
  ClientBloc bloc;
  CustomSearchDelegate(this.clientDataSources, this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: clientDataSources.searchClient(query.toLowerCase()),
      builder: (context, snapshot) {
        inspect(snapshot.data);
        if (snapshot.hasData) {
          return ListViewClientTile(
              scrollController: null, listClients: snapshot.data!, bloc: bloc);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
