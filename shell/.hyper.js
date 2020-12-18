
module.exports = {
  config: {
  updateChannel: "stable",
    summon: {
      hotkey: "cmd+shift+z"
    },
    hyperlinks: {
      defaultBrowser: false
    },
    opacity: {
      focus: 0.98,
      blur: 0.80
    },
    fontSize: 16,
    fontFamily:
      '"Hasklug Nerd Font",Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: "350",
    fontWeightBold:"600",
    lineHeight: 1,
    letterSpacing: 0,
    cursorColor: "rgba(248,28,229,0.8)",
    cursorAccentColor: "#000",
    cursorShape: "BEAM",
    cursorBlink: true,
    foregroundColor: "#fff",
    backgroundColor: "#000",
    selectionColor: "rgba(248,28,229,0.3)",
    borderColor: "#333",
    css: "",
    termCSS: "",
    showHamburgerMenu: "",
    showWindowControls: "",
    padding: "12px 14px",
    colors: {
      black: "#000000",
      red: "#C51E14",
      green: "#1DC121",
      yellow: "#C7C329",
      blue: "#0A2FC4",
      magenta: "#C839C5",
      cyan: "#20C5C6",
      white: "#C7C7C7",
      lightBlack: "#686868",
      lightRed: "#FD6F6B",
      lightGreen: "#67F86F",
      lightYellow: "#FFFA72",
      lightBlue: "#6A76FB",
      lightMagenta: "#FD7CFC",
      lightCyan: "#68FDFE",
      lightWhite: "#FFFFFF"
    },
    shell: "zsh",
    shellArgs: ["--login"],
    env: {},
    bell: false,
    copyOnSelect: true,
    defaultSSHApp: true,
    quickEdit: false,
    macOptionSelectionMode: "vertical",
    webGLRenderer: true
  },
  plugins: [
    // "hyper-nord",
    // "hyper-ayu",
    // "hyper-one-dark-vivid",
    // "hyper-chesterish",
    "hyperterm-gruvbox-dark",
    "hyper-opacity",
    "hyperterm-summon",
    "hyper-alt-click",
    "hyperterm-tabs",
    "hypercwd",
    "hyper-tab-icons",
    "hyper-statusline",
    "hyper-pane",
    "hyper-tabs-enhanced",
  ],
  localPlugins: [],

  keymaps: {
    // Example
    "window:devtools": "cmd+alt+o"
  }
}
