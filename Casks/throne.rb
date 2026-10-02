cask "throne" do
  version "1.3.2"

  # Отдельные sha256 для каждой архитектуры
  on_arm do
    sha256 "c5371633f17e46d18d999206a79bafe4ec1b20e03acf51171261f3084b702b16"

    url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "b5312bd4b6aceb5d2107be06fb6a407ec4da5159c5da0b428ac26c784bf404a9"

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
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-d", "com.apple.quarantine", "{{appdir}}/Throne.app"]
  end

  uninstall quit: "moe.Throne.macosx"

  zap trash: [
    "~/Library/Application Support/Throne",
    "~/Library/Caches/Throne",
    "~/Library/Preferences/Throne",
    "~/Library/Saved Application State/Throne.savedState",
  ]
end
