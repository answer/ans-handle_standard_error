# Ans::HandleStandardError

コントローラに include すると standard error を rescue するようになる

## Installation

Add this line to your application's Gemfile:

    gem 'ans-handle_standard_error'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ans-handle_standard_error

## Usage

    class Posts < ActionController::Base
      include Ans::HandleStandardError

      private

      def rescue_from_standard_error_render(e)
        render "not_found", status: 500
      end
    end

production 環境の場合のみ、 `rescue_from StandardError, with: :rescue_from_standard_error` を設定する

最終的な表示の部分は `rescue_from_standard_error_render` メソッドによって行う

このメソッドには、発生した例外が渡される

デフォルトは発生した例外を再度 raise

### 生成されるログ

エラーログは logger で出力する

これにより、通常のログファイルにエラーが書き込まれる

エラーメッセージにはハッシュタグを含め、ハッシュタグは error.log に出力する

エラーメッセージにはバックトレースが含まれるため、バッファが有効な logger を使いたい

logger は通常のログファイルに書き込むので、

* エラーが起こったこと
* エラーの位置

の検出が難しい

これをハッシュタグで解決しようとしている

ハッシュタグは ==#{id}== の形式

エラーメッセージとバックトレースを囲むように出力している


## 再定義可能なメソッド

* `rescue_from_standard_error_id`
* `rescue_from_standard_error_log`
* `rescue_from_standard_error_render(e)`
* `self.rescue_from_standard_error?`

### rescue_from_standard_error

1. 発生した例外のメッセージとバックトレースを `logger.fatal` でログに書き出す
2. ハッシュコードを生成して `logger.fatal` でログに書き出す
3. log/error.log にハッシュコードを出力する
4. `rescue_from_standard_error_render` メソッドをコールする

### rescue_from_standard_error_id

エラーログに出力するハッシュコードを生成する

デフォルトは `==#{SecureRandom.hex(20)}== #{Time.now}`

### rescue_from_standard_error_log

エラーログの絶対パスを返す

デフォルトは `Rails.root.join("log/error.log")`

### rescue_from_standard_error_render(e)

`rescue_from_standard_error` メソッドの最後に呼び出され、適切なテンプレートの描画を行う

デフォルトは `raise e`(発生した例外の再掲)

### self.rescue_from_standard_error?

`include Ans::HandleStandardError` の前に、以下のように再定義する

    class Posts < ActionController::Base
      module ::Ans::HandleStandardError
        def self.rescue_from_standard_error?
          true
        end
      end
      include Ans::HandleStandardError
    end

デフォルトは Rails.env.production?

開発時に、一時的に有効にするときなどに再定義する

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
