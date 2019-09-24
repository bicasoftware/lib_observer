import 'package:flutter/widgets.dart';
import 'package:lib_observer/awaiting_container.dart';

class StreamObserver<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) onSuccess;
  final Widget Function(BuildContext context) onAwaiting;
  final Widget Function(BuildContext context, Error erro) onError;

  Function get _defaultError => (context, error) => Center(child: Text(error));

  Function get _defaultAwaiting => (context) => AwaitingContainer();

  const StreamObserver({
    Key key,
    @required this.stream,
    @required this.onSuccess,
    this.onAwaiting,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return onError == null
              ? _defaultError(context, snapshot.error)
              : onError(context, snapshot.error);
        }

        if (!snapshot.hasData) {
          return onAwaiting == null
              ? _defaultAwaiting(context)
              : onAwaiting(context);
        } else {
          return onSuccess(context, snapshot.data);
        }
      },
    );
  }
}
