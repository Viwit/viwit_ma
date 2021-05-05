import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viwit_ma/src/auth/form_subbmision_status.dart';
import 'package:viwit_ma/src/auth/auth_repository.dart';
import 'package:viwit_ma/src/auth/login/login_event.dart';
import 'package:viwit_ma/src/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    //username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      //Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      //Form Submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authRepo.login();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}