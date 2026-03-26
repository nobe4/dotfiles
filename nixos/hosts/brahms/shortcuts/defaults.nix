# All options and their default values, should roughly match what's
# happening when you press "Restore Defaults".
mkShortcut: {
  Dock = {
    hiding = mkShortcut {
      id = 52;
      name = "Turn Dock hiding on/off";
      mods = [
        "command"
        "option"
      ];
      key = "d";
    };
  };

  Display = {
    decreaseBrightness = mkShortcut {
      id = 53;
      name = "Decrease display brightness";
      enabled = false;
      key = "F1";
    };
    increaseBrightness = mkShortcut {
      id = 54;
      name = "Increase display brightness";
      enabled = false;
      key = "F2";
    };
  };

  MissionControl = {
    missionControl = mkShortcut {
      id = 32;
      name = "Mission Control";
      mods = [ "control" ];
      key = "UpArrow";
    };
    showDesktop = mkShortcut {
      id = 36;
      name = "Show Desktop";
      key = "F11";
    };
    moveLeftSpace = mkShortcut {
      id = 79;
      name = "Move left a space";
      mods = [ "control" ];
      key = "LeftArrow";
    };
    moveRightSpace = mkShortcut {
      id = 81;
      name = "Move right a space";
      mods = [ "control" ];
      key = "RightArrow";
    };
  };

  InputSources = {
    prevInputSource = mkShortcut {
      id = 60;
      name = "Select the previous input source";
      enabled = false;
      key = "Space";
    };
    nextInputSource = mkShortcut {
      id = 61;
      name = "Select the next source in input menu";
      enabled = false;
      key = "Space";
    };
  };

  Spotlight = {
    search = mkShortcut {
      id = 64;
      name = "Show Spotlight search";
      mods = [ "command" ];
      key = "Space";
    };
    finderSearch = mkShortcut {
      id = 65;
      name = "Show Finder search window";
      mods = [
        "command"
        "option"
      ];
      key = "Space";
    };
  };
}
