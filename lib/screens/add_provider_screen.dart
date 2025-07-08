import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usc_faker/bloc/UscProvider/usc_provider_bloc.dart';

class AddProviderScreen extends StatefulWidget {
  AddProviderScreen({Key? key}) : super(key: key);

  @override
  _AddProviderScreenState createState() => _AddProviderScreenState();
}

class _AddProviderScreenState extends State<AddProviderScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _activity = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      _title = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      _activity = value;
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          BlocProvider.of<UscProviderBloc>(context)
                              .add(AddUscProvider({
                            "Title": _title,
                            "activity": _activity,
                          }));
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Hinzufügen"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
