import 'package:flutter/material.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';
import 'package:leaps/features/search/presentation/widgets/resource_state_change.dart';
import 'package:provider/provider.dart';

class NetworkWidget extends StatelessWidget {
  final Widget child;
  const NetworkWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var network = Provider.of<ConnectionStatus>(context);

    if (network == ConnectionStatus.Wifi ||
        network == ConnectionStatus.Mobile) {
      return Container(
        child: child,
      );
    }

    return LayoutBuilder(builder: (context, constraint) {
      var _height = constraint.maxHeight;
      var _width = constraint.maxWidth;

      return Container(
        height: _height,
        width: _width,
        child: ResourceStateChangeWidget(
          isEmptyState: false,
        ),
      );
    });
  }
}
