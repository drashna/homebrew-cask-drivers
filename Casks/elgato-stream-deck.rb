cask 'elgato-stream-deck' do
  version '4.3.3.11845'
  sha256 'e862e76b0d765dfc4ed1329682c3656dd7f655c52f8265331ea4bf30796d4fcc'

  url "https://edge.elgato.com/egc/macos/sd/Stream_Deck_#{version}.pkg"
  appcast 'https://help.elgato.com/hc/en-us/articles/360028242631-Elgato-Stream-Deck-Software-Release-Notes',
          configuration: version.major_minor
  name 'Elgato Stream Deck'
  homepage 'https://www.elgato.com/en/gaming/stream-deck'

  depends_on macos: '>= :sierra'

  pkg "Stream_Deck_#{version}.pkg"

  uninstall launchctl: 'com.elgato.StreamDeck',
            quit:      'com.elgato.StreamDeck',
            pkgutil:   'com.elgato.StreamDeck'

  zap trash: [
               '~/Library/Application Support/com.elgato.StreamDeck',
               '~/Library/Caches/com.elgato.StreamDeck',
               '~/Library/Caches/com.plausiblelabs.crashreporter.data/com.elgato.StreamDeck',
               '~/Library/Preferences/com.elgato.StreamDeck.plist',
             ]
end
