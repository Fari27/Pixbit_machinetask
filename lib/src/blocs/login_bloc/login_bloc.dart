import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/models/login_model.dart';
import 'package:sample/src/repositories/login_repository.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository? loginRepository;
  LoginBloc({this.loginRepository}) : super(LoginInitial()) {
    on<LoginRequestEvent>((event, emit) async {
      await _loginRequest(event, emit);
    });
    on<ButtonEnableEvent>((event, emit) {
      emit(ButtonEnableState(buttonEnabled: event.buttonEnabled));
    });
    on<PwdVisibleEvent>((event, emit) {
      emit(PwdVisibleState(
        obsecureEnabled: event.obsecureEnabled,
        controllerCheck: event.controllerCheck,
      ));
    });
  }

  Future<void> _loginRequest(
      LoginRequestEvent event, Emitter<LoginState> emit) async {
    try {
      final LoginModel loginResponse =
          await (loginRepository ?? LoginRepository())
              .loginRequest(postParams: event.reqParams);
    
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', event.reqParams["email"]);
      prefs.setString('jwtToken', loginResponse.data?.accessToken ?? '');
      emit(LoginAuthenticationState(
          status: ApiRequestStatus.success, resp: loginResponse));
    } catch (e) {
       print("object");
    }
  }
}
