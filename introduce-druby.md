# dRubyの紹介

subtitle
: 19年目のdRuby

author
: 中島 滋(@ledsun)

institution
: 株式会社ラグザイア

date
: 2024/09/25

place
: 第三回 町田SE-meetup

theme
: blue-circle

# dRubyとは

今日はdRubyについて紹介したいと思います。dRubyはRubyのライブラリーの1つです。
dRubyのdはdistributedのdです。
分散の意味です。

# 分散

ここでの分散は、複数のプロセスに分散するという意味です。

# たとえるなら

リモートプロシジャコールの仲間です。CORBAやJavaのJava Message Service、SOAPを使ったWebサービスなどをイメージしてもらうえるとわかりやすいと思います。
例えが古いんですけど、dRubyも1999年生まれ。20世紀のテクノロジーです。

# irbで試してみる

Rubyにはirbという対話型のシェルがあります。これを使ってdRubyを試してみましょう。


    irb -r drb
{: lang="shell"}

# 試してみましょう

サーバー

    class Foo
      def greeting = puts 'Hello, World.'
    end
    DRb.start_service 'druby://localhost:54320', Foo.new
{: lang="ruby"}


# 試してみましょう (続き)


クライアント

```ruby
foo = DRbObject.new_with_uri 'druby://localhost:54320'
foo.greeting
```

どうなるでしょうか？

# 試してみましょう (まとめ)

Remote Method Invocationできることがわかりました。

# 最初の面白い点

RubyではdRubyがRubyに標準添付されています。
JavaのJMSの場合は、J2SEには入っていなくて、J2EEに入っていました。

# データの共有

サーバーでハッシュ公開します。

```ruby
DRb.start_service 'druby://localhost:54321', Hash.new
```

# データの共有 (続き)

クライアントで数値を設定します。

```ruby
kvs = DRbObject.new_with_uri 'druby://localhost:54321'
kvs[:number] = 1
```

# データの共有 (続き)

クライアントをもう1つひらいて、値を確認

```ruby
kvs = DRbObject.new_with_uri 'druby://localhost:54321'
kvs[:number]
```

さらに、値を設定

```ruby
kvs[:number] = 2
```

# データの共有 (続き)

クライアント1に戻って

```ruby
kvs[:number]
```

どうなるでしょうか？

# データの共有 (まとめ)

値を共有できていることがわかります。
こんな感じで、dRubyを使うと簡単にサーバーを経由して値を共有できます。
この仕組みをつかってテストを並列分散実行する仕組みを作っている人達もいるみたいです。

# 変な物を共有する

Rubyには`$stdout`というグローバル変数があります。
文字通り標準出力を表してます。

```ruby
$stdout.puts 'hi'
```

hi が表示されます。
`puts ‘hi’` と同じ動きです。

# 変な物を共有する (続き)

クライアント1で

```ruby
DRb.start_service
kvs[:stdout] = $stdout
```

# 変な物を共有する (続き)

クライアント2で

```ruby
kvs[:stdout].puts 'Hello'
```

どうなるでしょうか？

# 変な物を共有する (続き)

1. エラーになる
2. クライアント1で'Hello'が表示される
3. クライアント2で'Hello'が表示される


# 変な物を共有する (続き)

クライアント1に'Hello'表示されます。
この動き、ぶっとんでいると思いませんか？

# 変な物を共有する (まとめ)

クライアント1の DRb.start_service がミソ。クライアントだけどサーバーにもなっています。

# リモート呼び出しとのちがい

最初CORBAやJMSに似てるって言った。けど、すこしちがう。CORBAやJMSは、クライアントからサーバーを呼び出す仕組みをつくって、あとは使う人がよしなにって感じ。
dRubyには、クライアントから共有したオブジェクトを別のクライアントから呼び出す呼び出す仕組みも入っている。クライアント2はクライアント1のURLを知らなくても呼び出せる。

# 分散

全てのノードがクライアントにもサーバーにもなりやすい仕組み。クライアント-サーバーを作るための仕組みじゃなくて、分散コンピューティングするための仕組み。
dRubyのdはdistributedのdです。
分散の意味です。

# まとめ

だからなんなの？って思うじゃないですか？僕もよくわかっていません。
dRubyの存在を2005年に知って、そのとき試してわからなかった。19年経っても全然わっかんねーわ

# 参考文献

* 関 将俊 "n月刊ラムダノート Vol.2, No.1(2020)"
* 関 将俊 "dRubyによる分散・Webプログラミング"
* @makicamel "dRuby 入門者によるあなたの身近にあるdRuby 入門"


# 提供

![](luxiar_logo.svg){:relative_width='100'}
