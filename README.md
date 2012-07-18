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

### rescue_from_standard_error

1. 発生した例外のメッセージとバックトレースを `logger.fatal` でログに書き出す
2. ハッシュコードを生成して `logger.fatal` でログに書き出す
3. log/error.log にハッシュコードを出力する
4. `rescue_from_standard_error_render` メソッドをコールする

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
