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
    showNotificationCenter = mkShortcut {
      id = 163;
      name = "Show Notification Center";
    };
    doNotDisturb = mkShortcut {
      id = 175;
      name = "Turn Do Not Disturb on/off";
    };
    applicationWindows = mkShortcut {
      id = 33;
      name = "Application windows";
      mods = [ "control" ];
      key = "DownArrow";
    };
    showDesktop = mkShortcut {
      id = 36;
      name = "Show Desktop";
      key = "F11";
    };
    stageManager = mkShortcut {
      id = 222;
      name = "Turn Stage Manager on/off";
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
    switchDesktop1 = mkShortcut {
      id = 118;
      name = "Switch to Desktop 1";
      mods = [ "control" ];
      key = "1";
    };
    switchDesktop2 = mkShortcut {
      id = 119;
      name = "Switch to Desktop 2";
      mods = [ "control" ];
      key = "2";
    };
    switchDesktop3 = mkShortcut {
      id = 120;
      name = "Switch to Desktop 3";
      mods = [ "control" ];
      key = "3";
    };
    quickNote = mkShortcut {
      id = 190;
      name = "Quick Note";
      mods = [ "fn" ];
      key = "q";
    };
    gameOverlay = mkShortcut {
      id = 260;
      name = "Game Overlay";
      mods = [ "command" ];
      key = "Escape";
    };
  };

  Windows = {
    minimize = mkShortcut {
      id = 233;
      name = "Minimize";
      mods = [ "command" ];
      key = "m";
    };
    zoom = mkShortcut {
      id = 235;
      name = "Zoom";
    };
    fill = mkShortcut {
      id = 237;
      name = "Fill";
      mods = [
        "control"
        "fn"
      ];
      key = "f";
    };
    center = mkShortcut {
      id = 238;
      name = "Center";
      mods = [
        "control"
        "fn"
      ];
      key = "c";
    };
    returnToPreviousSize = mkShortcut {
      id = 239;
      name = "Return to Previous Size";
      mods = [
        "control"
        "fn"
      ];
      key = "r";
    };
    tileLeftHalf = mkShortcut {
      id = 240;
      name = "Tile Left Half";
      mods = [
        "control"
        "fn"
      ];
      key = "LeftArrow";
    };
    tileRightHalf = mkShortcut {
      id = 241;
      name = "Tile Right Half";
      mods = [
        "control"
        "fn"
      ];
      key = "RightArrow";
    };
    tileTopHalf = mkShortcut {
      id = 242;
      name = "Tile Top Half";
      mods = [
        "control"
        "fn"
      ];
      key = "UpArrow";
    };
    tileBottomHalf = mkShortcut {
      id = 243;
      name = "Tile Bottom Half";
      mods = [
        "control"
        "fn"
      ];
      key = "DownArrow";
    };
    tileTopLeftQuarter = mkShortcut {
      id = 244;
      name = "Tile Top Left Quarter";
    };
    tileTopRightQuarter = mkShortcut {
      id = 245;
      name = "Tile Top Right Quarter";
    };
    tileBottomLeftQuarter = mkShortcut {
      id = 246;
      name = "Tile Bottom Left Quarter";
    };
    tileBottomRightQuarter = mkShortcut {
      id = 247;
      name = "Tile Bottom Right Quarter";
    };
    arrangeLeftAndRight = mkShortcut {
      id = 248;
      name = "Arrange Left and Right";
      mods = [
        "control"
        "shift"
        "fn"
      ];
      key = "LeftArrow";
    };
    arrangeRightAndLeft = mkShortcut {
      id = 249;
      name = "Arrange Right and Left";
      mods = [
        "control"
        "shift"
        "fn"
      ];
      key = "RightArrow";
    };
    arrangeTopAndBottom = mkShortcut {
      id = 250;
      name = "Arrange Top and Bottom";
      mods = [
        "control"
        "shift"
        "fn"
      ];
      key = "UpArrow";
    };
    arrangeBottomAndTop = mkShortcut {
      id = 251;
      name = "Arrange Bottom and Top";
      mods = [
        "control"
        "shift"
        "fn"
      ];
      key = "DownArrow";
    };
    arrangeInQuarters = mkShortcut {
      id = 256;
      name = "Arrange in Quarters";
      enabled = false;
    };
    fullScreenTileLeft = mkShortcut {
      id = 257;
      name = "Full Screen Tile Left";
      enabled = false;
    };
    fullScreenTileRight = mkShortcut {
      id = 258;
      name = "Full Screen Tile Right";
      enabled = false;
    };
  };

  Keyboard = {
    tabMovesFocus = mkShortcut {
      id = 13;
      name = "Change the way Tab moves focus";
      mods = [ "control" ];
      key = "F7";
    };
    keyboardAccess = mkShortcut {
      id = 12;
      name = "Turn keyboard access on or off";
      mods = [ "control" ];
      key = "F1";
    };
    focusMenuBar = mkShortcut {
      id = 7;
      name = "Move focus to the menu bar";
      mods = [ "control" ];
      key = "F2";
    };
    focusDock = mkShortcut {
      id = 8;
      name = "Move focus to the Dock";
      mods = [ "control" ];
      key = "F3";
    };
    focusActiveWindow = mkShortcut {
      id = 9;
      name = "Move focus to active or next window";
      mods = [ "control" ];
      key = "F4";
    };
    focusWindowToolbar = mkShortcut {
      id = 10;
      name = "Move focus to window toolbar";
      mods = [ "control" ];
      key = "F5";
    };
    focusFloatingWindow = mkShortcut {
      id = 11;
      name = "Move focus to floating window";
      mods = [ "control" ];
      key = "F6";
    };
    focusNextWindow = mkShortcut {
      id = 27;
      name = "Move focus to next window";
      mods = [ "command" ];
      key = "`";
    };
    focusStatusMenus = mkShortcut {
      id = 57;
      name = "Move focus to status menus";
      mods = [ "control" ];
      key = "F8";
    };
    contextualMenu = mkShortcut {
      id = 159;
      name = "Show contextual menu";
      mods = [ "control" ];
      key = "F8";
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

  Screenshots = {
    saveScreen = mkShortcut {
      id = 28;
      name = "Save picture of screen as file";
      mods = [
        "shift"
        "command"
      ];
      key = "3";
    };
    copyScreen = mkShortcut {
      id = 29;
      name = "Copy picture of screen to the clipboard";
      mods = [
        "control"
        "shift"
        "command"
      ];
      key = "3";
    };
    saveSelectedArea = mkShortcut {
      id = 30;
      name = "Save picture of selected area as file";
      mods = [
        "shift"
        "command"
      ];
      key = "4";
    };
    copySelectedArea = mkShortcut {
      id = 31;
      name = "Copy picture of selected area to the clipboard";
      mods = [
        "control"
        "shift"
        "command"
      ];
      key = "4";
    };
    screenshotOptions = mkShortcut {
      id = 184;
      name = "Screenshot and recording options";
      mods = [
        "shift"
        "command"
      ];
      key = "5";
    };
  };

  PresenterOverlay = {
    presenterOverlaySmall = mkShortcut {
      id = 224;
      name = "Turn Presenter Overlay (small) on or off";
      enabled = false;
    };
    presenterOverlayLarge = mkShortcut {
      id = 223;
      name = "Turn Presenter Overlay (large) on or off";
      enabled = false;
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
    showApps = mkShortcut {
      id = 160;
      name = "Show Apps";
    };
  };
}
