# Ruby on Rails チュートリアルのサンプルアプリケーション

これは、次の教材で作られたサンプルアプリケーションです。
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
（第8版）
[Michael Hartl](https://www.michaelhartl.com/) 著

## ライセンス

[Ruby on Rails チュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は [LICENSE.md](LICENSE.md) をご覧ください。

## 使い方

このアプリケーションを動かす場合は、まずはリポジトリをフォークしてください。

フォークしたリポジトリで、「Code」から「Codespaces」タブに移動し、
「Create codespace on main」をクリックすると環境構築がスタートします。
Railsサーバーが立ち上がり、シンプルブラウザが表示されるまでしばらくお待ちください。

次に、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

詳しくは、[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
を参考にしてください。

## Render にデプロイする場合（`secret_key_base` エラー対策）

Render の build / 起動時に `secret_key_base` が必要です。
`config/master.key` はリポジトリに含まれないため（`.gitignore` で除外）、Render 側で次のいずれかを設定してください。

- 推奨: `RAILS_MASTER_KEY` を Render の Environment Variables に設定
	- 値はローカルの `config/master.key` の中身
	- これにより `config/credentials.yml.enc` が復号でき、`secret_key_base` も取得できます
- 代替: `SECRET_KEY_BASE` を Render の Environment Variables に設定
	- `bin/rails secret` で生成した十分に長いランダム文字列を設定

補足:

- `RAILS_SERVE_STATIC_FILES=1` を設定すると、Rails がプリコンパイル済みアセットを配信できます
- build の `assets:precompile` だけ通したい場合は、build 時だけ `SECRET_KEY_BASE_DUMMY=1` を設定する方法もあります（ただし本番起動には上記どちらかの設定が必要です）

`config/master.key` を誤ってコミットしてしまった場合は、追跡から外した上でキーをローテーションしてください。

```
git rm --cached config/master.key
```
