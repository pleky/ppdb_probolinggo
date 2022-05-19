import 'package:flutter/cupertino.dart';

extension Spacing on double {
  SizedBox height({double multipicationFactor = 1}) {
    return SizedBox(height: this * multipicationFactor);
  }

  SizedBox width({double multipicationFactor = 1}) {
    return SizedBox(width: this * multipicationFactor);
  }
}
