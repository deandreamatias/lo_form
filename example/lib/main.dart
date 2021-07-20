import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'fake_repo.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm Demo',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: HelloForm(),
          ),
        ),
      ),
    );
  }
}

class HelloForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoForm(
      initialValues: const {
        'name': 'whoami',
      },
      validate: (values) {
        if (values['name'] == 'someone') return {'name': 'Who are you?'};
      },
      onChanged: (state) => print('Form Changed'),
      onSubmit: (values) async {
        try {
          final name = values['name'] as String;
          final message = await FakeRepo.greet(name);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
        } catch (e) {
          return {'name': e.toString()};
        }
      },
      builder: (formState) {
        return Column(
          children: [
            LoTextField(
              name: 'name',
              validate: (value) {
                if (value.isEmpty) return 'You cannot be no one';
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: formState.status.isValid ? formState.submit : null,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16),
            Text(formState.touched.toString()),
          ],
        );
      },
    );
  }
}