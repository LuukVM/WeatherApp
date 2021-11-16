import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetState.loading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          emitInternetConnected(ConnectionType.Wifi);
          break;
        case ConnectivityResult.mobile:
          emitInternetConnected(ConnectionType.Mobile);
          break;
        case ConnectivityResult.none:
          emitInternetDisconnected();
          break;
        default:
          emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) => emit(state
      .copyWith(status: InternetStatus.connected, connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetState.disconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
