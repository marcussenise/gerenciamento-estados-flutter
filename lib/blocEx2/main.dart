// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanegement/blocEx2/apis/login_api.dart';
import 'package:statemanegement/blocEx2/apis/notes_api.dart';
import 'package:statemanegement/blocEx2/bloc/actions.dart';
import 'package:statemanegement/blocEx2/bloc/app_bloc.dart';
import 'package:statemanegement/blocEx2/bloc/app_state.dart';
import 'package:statemanegement/blocEx2/dialogs/generic_dialog.dart';
import 'package:statemanegement/blocEx2/dialogs/loading_screen.dart';
import 'package:statemanegement/blocEx2/models.dart';
import 'package:statemanegement/blocEx2/strings.dart';
import 'package:statemanegement/blocEx2/views/iterable_list_view.dart';
import 'package:statemanegement/blocEx2/views/login_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(loginApi: LoginApi(), notesApi: NotesApi()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(homePage),
          ),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, appState) {
              //loading screen
              if (appState.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: pleaseWait,
                );
              } else {
                LoadingScreen.instance().hide();
              }
              // display possible errors
              final loginError = appState.loginError;
              if (loginError != null) {
                showGenericDialog(
                  context: context,
                  title: loginErrorDialogTitle,
                  content: loginErrorDialogContent,
                  optionBuilder: () => {
                    ok: true,
                  },
                );
              }

              //if we are logged in, but we have no fetched notes, fetch them now
              if (
                appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.fooBar() &&
                appState.fetchedNotes == null
              ){
                context.read<AppBloc>().add(LoadNotesAction());
              }
            },
            builder: (context, appState) {
              final notes = appState.fetchedNotes;
              if (notes == null) {
                return LoginView(onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                    LoginAction(email: email, password: password)
                  );
                });
              } else {
                return notes.toListView();
              }
            },
          )),
    );
  }
}
