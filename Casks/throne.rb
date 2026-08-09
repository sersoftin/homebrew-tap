cask "throne" do
  version "1.2.4"

  # Отдельные sha256 для каждой архитектуры
  on_arm do
    sha256 "ef9fb2209088701e4926d3520712c6b6f737b81d8b6c40e139b7a913840f48eb"

    url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "09dc2b830d0967bd7dfb6028c6ed513ac82ed1aaf0082f4b2b5ec326b8636f8a"

    url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-amd64.zip"
  end

  name "Throne"
  desc "Cross-platform GUI proxy utility powered by sing-box"
  homepage "https://github.com/throneproj/Throne"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  # Важно: приложение не подписано, нужен workaround
  app "Throne/Throne.app"

  # Удалить карантин после установки (т.к. нет подписи)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{appdir}/Throne.app"],
                   sudo: false
  end

  uninstall quit: "moe.Throne.macosx"

  zap trash: [
    "~/Library/Application Support/Throne",
    "~/Library/Caches/Throne",
    "~/Library/Preferences/Throne",
    "~/Library/Saved Application State/Throne.savedState",
  ]
end
