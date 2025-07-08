import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usc_faker/bloc/UscProvider/usc_provider_bloc.dart';
import 'package:usc_faker/screens/add_provider_screen.dart';
import 'package:usc_faker/screens/checked_in_screen.dart';

class ProviderSelectionScreen extends StatefulWidget {
  const ProviderSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ProviderSelectionScreen> createState() =>
      _ProviderSelectionScreenState();
}

class _ProviderSelectionScreenState extends State<ProviderSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<UscProviderBloc>.value(
                    value: BlocProvider.of<UscProviderBloc>(context),
                  ),
                ],
                child: AddProviderScreen(),
              ),
              settings: RouteSettings(name: 'AddProviderScreen'),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          child: BlocBuilder<UscProviderBloc, UscProviderState>(
            builder: (context, uscProviderState) {
              if (uscProviderState is UscProviderLoaded) {
                return Column(
                  children: uscProviderState.provider
                      .map((item) => Card(
                            elevation: 5,
                            child: new InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CheckedInScreen(provider: item),
                                    settings:
                                        RouteSettings(name: 'CheckedInScreen'),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.maxFinite,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['Title']!,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
