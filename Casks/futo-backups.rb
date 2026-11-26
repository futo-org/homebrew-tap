cask "futo-backups" do
  version "1.23.0"
  sha256 "63def65b86b7bc4ddd254f20ca0ba73f4401fc9c84e28bb4a25dfc7a839916ac"

  url "https://github.com/futo-org/backups/releases/download/macos-v#{version}/FUTO-Backups-#{version}.zip"
  name "FUTO Backups"
  desc "Encrypted, scheduled backups to FUTO Cloud"
  homepage "https://backups.futo.cloud/"

  livecheck do
    url "https://github.com/futo-org/backups/releases/download/macos-appcast/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :tahoe

  app "FUTO Backups.app"

  uninstall quit: "org.futo.backups.mac"

  zap trash: [
    "~/Library/Application Support/FUTO Backups",
    "~/Library/Caches/FUTO Backups",
    "~/Library/Caches/org.futo.backups.mac",
    "~/Library/HTTPStorages/org.futo.backups.mac",
    "~/Library/HTTPStorages/org.futo.backups.mac.binarycookies",
    "~/Library/Preferences/org.futo.backups.mac.plist",
    "~/Library/Saved Application State/org.futo.backups.mac.savedState",
  ]

  caveats <<~EOS
    #{token} is alpha software.

    Uninstalling, even with --zap, leaves its sign-in and recovery key in the login
    keychain under "org.futo.backups.mac". To remove them, use Settings > Unlink This Mac
    in the app before uninstalling, or delete them in Keychain Access.
  EOS
end
