import 'package:flutter/material.dart';
import '../constants/enums.dart';



class UiHandler extends StatelessWidget {
  const UiHandler({
    super.key,
    required this.uiState,
    required this.loadingWidget,
    required this.defaultWidget,
    this.successWidget,
    this.errorWidget,
    this.emptyWidget,
    this.isSliver = false,
  });

  final UiState uiState;
  final Widget loadingWidget;
  final Widget? emptyWidget;
  final Widget defaultWidget;
  final Widget Function()? successWidget;
  final Widget Function()? errorWidget;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    Widget buildWidget(Widget widget) {
      return isSliver ? SliverToBoxAdapter(child: widget) : widget;
    }

    switch (uiState) {
      case UiState.loading:
        return buildWidget(loadingWidget);
      case UiState.success:
        return buildWidget(successWidget?.call() ?? defaultWidget);
      case UiState.error:
        return buildWidget(errorWidget?.call() ?? defaultWidget);
      case UiState.emptyData:
        return buildWidget(
          Center(
            child: emptyWidget ?? Text("no_data"),
          ),
        );
      case UiState.paginationLoading:
        return buildWidget(successWidget?.call() ?? defaultWidget);
      case UiState.paginationError:
        return buildWidget(successWidget?.call() ?? defaultWidget);
      }
  }
}