# dotfiles

macOS用のNeovim、WezTerm、Starship、Zsh設定です。

## セットアップ

新しいMacでリポジトリをcloneしてから、次を実行します。

```sh
./setup.sh
```

`setup.sh`はHomebrewがなければ公式installerで導入してから、`neovim`、`starship`、WezTerm、Moralerspace HWフォントを導入します。Apple Siliconでは`/opt/homebrew/bin/brew`、Intel Macでは`/usr/local/bin/brew`の`brew shellenv`を反映します。以下をシンボリックリンクします。

- `~/.config/nvim`
- `~/.config/wezterm`
- `~/.config/starship.toml`
- `~/.zshrc`
- `~/.zprofile`

既存ファイルがある場合は上書きせず、同じ場所に`.dotfiles-backup`を付けて一度だけ退避します。既にその退避先がある場合は安全のため停止します。2回目以降の実行は同じリンクを維持します。

`./setup.sh --skip-packages`はパッケージ導入を省略してリンクだけを作ります。検証や、必要なパッケージを別途導入済みの場合に利用できます。

Zshには`ls`/`ll`のalias、viモードのキーバインド、Starship初期化、ホーム以外へ移動した際の`ll`表示を設定します。`~/.zprofile`はHomebrewの`brew shellenv`だけを設定します。履歴・補完・その他の`setopt`設定は含めません。

## GitHub Actionsによる検証

`.github/workflows/verify.yml`はpush、pull request、手動実行で、GitHub-hosted macOSランナー上に隔離した一時HOMEを作成し、セットアップを2回実行します。その後、リンク、login interactive ZshでのHomebrew読み込み、Zsh構文、alias、すべてのviキーバインド、`KEYTIMEOUT`、`chpwd`を検証します。標準macOSランナーにはHomebrewが事前導入されているため、Homebrew installerを実行する経路はこのworkflowでは未検証です。また、工場出荷状態のMacやGUI操作、Apple ID、権限ダイアログ、Touch ID、実際のキー操作感までは再現しません。
