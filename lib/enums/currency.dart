enum Currency {
  multiprovaCoin,
  multiprovaToken;

  String get name {
    switch (this) {
      case Currency.multiprovaCoin:
        return 'MultiprovaCoin';
      case Currency.multiprovaToken:
        return 'MultiprovaToken';
    }
  }
}
