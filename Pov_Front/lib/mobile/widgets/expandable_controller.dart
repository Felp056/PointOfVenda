import 'package:flutter/material.dart';

class ExpandableController extends ValueNotifier<String?> {
  ExpandableController() : super(null);

  void expand(String widgetName) {
    if (value == widgetName) {
      value = null; // Retrata se já estiver expandido
    } else {
      value = widgetName; // Expande o novo widget
    }
  }
}
