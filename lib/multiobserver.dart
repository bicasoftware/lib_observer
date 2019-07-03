import 'package:flutter/material.dart';
import 'package:lib_observer/awaiting_container.dart';
import 'package:rxdart/rxdart.dart';

class MultiObserver extends StatelessWidget {
  final List<Stream> streams;
  final Widget Function(BuildContext context, List<Object> data) onSuccess;
  final Widget Function(BuildContext context) onAwaiting;
  final Widget Function(BuildContext context, Error erro) onError;

  Function get _defaultError => (context, error) => Center(child: Text(error));

  Function get _defaultAwaiting => (context) => AwaitingContainer();

  const MultiObserver({
    Key key,
    @required this.streams,
    @required this.onSuccess,
    this.onAwaiting,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Observable<List> zipStream = Observable.combineLatestList(streams);
    return StreamBuilder<List<Object>>(
      stream: zipStream,
      builder: (context, AsyncSnapshot<Object> snapshot) {
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
