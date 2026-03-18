cask "throne" do
  version "1.1.1"

  # Отдельные sha256 для каждой архитектуры
  on_arm do
    sha256 "9f88b8dfe894d9f87835716fa71a85b0aedc756e70192a3cfaeb8c958169a385"

    url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-arm64.zip"
  end
  on_intel do
    sha256 "b6e2bef9cc4fdc09518f5eb11daf524c8722bcb0047abe80d5831cbfd2a61e58"

    url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-amd64.zip"
  end

  name "Throne"
  desc "Cross-platform GUI proxy utility powered by sing-box"
  homepage "https://github.com/throneproj/Throne"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

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
