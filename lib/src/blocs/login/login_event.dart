part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends    Equatable {}
class LoginWithEmailAndPassword extends LoginEvent {
  final String email,password;

  LoginWithEmailAndPassword({@required this.email, @required  this.password});
   @override
  List<Object> get props => [email,password];

}