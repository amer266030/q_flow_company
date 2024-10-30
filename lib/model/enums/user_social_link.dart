import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';

enum LinkType { linkedIn, website, twitter }

extension LinkTypeExtension on LinkType {
  String get value {
    switch (this) {
      case LinkType.linkedIn:
        return 'LinkedIn';
      case LinkType.website:
        return 'Website';
      case LinkType.twitter:
        return 'Twitter';
    }
  }

  IconData get icon {
    switch (this) {
      case LinkType.linkedIn:
        return BootstrapIcons.linkedin;
      case LinkType.website:
        return BootstrapIcons.link_45deg;
      case LinkType.twitter:
        return BootstrapIcons.twitter_x;
    }
  }

  static LinkType fromString(String? gender) {
    switch (gender) {
      case 'LinkedIn':
        return LinkType.linkedIn;
      case 'Website':
        return LinkType.website;
      case 'Twitter':
        return LinkType.twitter;
      default:
        throw ArgumentError('Invalid link value');
    }
  }
}
