part of 'internet_cubit.dart';

enum InternetStatus { loading, connected, disconnected }

class InternetState extends Equatable {
  InternetState._({
    this.status = InternetStatus.loading,
    this.connectionType = ConnectionType.None,
  });

  InternetState.loading() : this._();

  InternetState.connected(ConnectionType connectionType, InternetStatus status)
      : this._(
            status: InternetStatus.connected, connectionType: connectionType);

  InternetState.disconnected() : this._(status: InternetStatus.disconnected);

  final InternetStatus status;
  final ConnectionType connectionType;

  @override
  List<Object> get props => [status, connectionType];

  InternetState copyWith({
    InternetStatus? status,
    ConnectionType? connectionType,
  }) {
    return InternetState.connected(
        connectionType ?? this.connectionType, status ?? this.status);
  }
}
