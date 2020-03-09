class FocusOut {
  void render() {
    if (distancePlayer > windowSize/12) {
      focusSize -= 0.15;
    } else {
      focusSize += 0.15;
    }
    if (focusSize > 1.5) {
      focusSize = 1.5;
    }
    if (focusSize < 1) {
      focusSize = 1;
    }
  }
}
