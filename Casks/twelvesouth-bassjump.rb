cask 'twelvesouth-bassjump' do
  if MacOS.version <= :mavericks
    version '2.5.1'
    sha256 '14408480cded51f6334753639e973ebbf2fc40f34ff64e1c35d2f32507d88afd'
  elsif MacOS.version == :yosemite
    version '3.0.0'
    sha256 '0f5507d69a3cd6247fda0977235db789c90d3e9f9de835dfe69c0ebf330b993d'
  elsif MacOS.version == :el_capitan
    version '3.0.1'
    sha256 '9aa2020f996dba7f66cfda20615e3a0fded4c974a32ae5cf6bb6626c9d06e541'
  else
    version '3.1.0'
    sha256 'ccffa678710f7636cfb7264f9a96a4aa74960c6722da9685fd43567417383853'
  end

  # ffe82a399885f9f28605-66638985576304cbe11c530b9b932f18.r24.cf2.rackcdn.com was verified as official when first introduced to the cask
  url "http://ffe82a399885f9f28605-66638985576304cbe11c530b9b932f18.r24.cf2.rackcdn.com/BassJumpInstaller_#{version}.dmg.zip"
  name 'BassJump'
  homepage 'https://www.twelvesouth.com/product/bassjump-2-for-macbook'

  container nested: "BassJumpInstaller_#{version}.dmg"

  if MacOS.version <= :el_capitan
    pkg 'BassJumpInstaller.pkg'
  else
    pkg 'BassJump Installer.pkg'
  end

  uninstall launchctl:  [
                          'com.twelvesouth.bassjump.observer',
                          'com.twelvesouth.bassjump.player',
                        ],
            quit:       [
                          'com.twelvesouth.BassJump',
                          'com.twelvesouth.BassJumpMenuExtra',
                        ],
            login_item: 'BassJumpMenuExtra',
            kext:       'com.twelvesouth.driver.BassJumpOverrideDriver',
            pkgutil:    [
                          'com.twelvesouth.bassjump.installer.halplugin',
                          'com.twelvesouth.bassjump.installer.overridekext',
                          'com.twelvesouth.bassjump.installer.prefpane',
                          'com.twelvesouth.installer.bassjump.application',
                          'com.twelvesouth.installer.bassjump.driver',
                          'com.twelvesouth.installer.bassjump.observer',
                          'com.twelvesouth.installer.bassjump.player',
                        ]

  zap trash: [
               '~/Library/Caches/com.twelvesouth.BassJump',
               '~/Library/Cookies/com.twelvesouth.BassJump.binarycookies',
               '~/Library/Preferences/com.twelvesouth.BassJump.plist',
               '~/Library/Preferences/com.twelvesouth.bassjump.observer.plist',
               '~/Library/Preferences/com.twelvesouth.bassjump.preferences.plist',
             ]

  caveats do
    reboot
  end
end
