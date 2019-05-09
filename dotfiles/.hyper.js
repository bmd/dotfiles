// Hyper Terminal preferences

module.exports = {
  config: {
    // Updates
    updateChannel: 'stable',

    // Text
    fontSize: 14,
    fontFamily: 'Consolas, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: 'normal',
    fontWeightBold: 'normal',
    lineHeight: 1,
    letterSpacing: 0,

    // Cursor
    cursorColor: 'rgba(255,255,255,0.5)',
    cursorAccentColor: '#000',
    cursorShape: 'BLOCK',
    cursorBlink: false,

    // Color
    foregroundColor: '#fff',
    backgroundColor: '#000',
    selectionColor: 'rgba(255,255,255,0.5)',
    borderColor: '#161716',
    colors: {
        black: '#000000',
        red: '#C51E14',
        green: '#1DC121',
        yellow: '#C7C329',
        blue: '#0A2FC4',
        magenta: '#C839C5',
        cyan: '#20C5C6',
        white: '#C7C7C7',
        lightBlack: '#686868',
        lightRed: '#FD6F6B',
        lightGreen: '#67F86F',
        lightYellow: '#FFFA72',
        lightBlue: '#6A76FB',
        lightMagenta: '#FD7CFC',
        lightCyan: '#68FDFE',
        lightWhite: '#FFFFFF',
      },

    // Styles
    css: '',
    termCSS: '',
    padding: '12px 14px',

    // Controls (igored on MacOS)
    showHamburgerMenu: '',
    showWindowControls: '',

    // Shell
    shell: '',
    shellArgs: ['--login'],
    env: {},
    bell: 'SOUND',

    // Preferences
    copyOnSelect: false,
    defaultSSHApp: true,
    quickEdit: false,
    macOptionSelectionMode: 'vertical',
    webGLRenderer: true,

    // Third-party plugin settings
    hyperBorder: {
      borderWidth: `3px`
    }
  },
  plugins: [
    "hyper-hide-scroll",
    'hyper-chesterish',
    'hyperborder',
  ],
  localPlugins: [],
  keymaps: {},
};
