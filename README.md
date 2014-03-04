# DataSmash

DataSmash is an elegant picoframework for working with data – converting from one form to another, or importing into a database/service. No assumptions have been made about how data is parsed, processed or handled to make it as straightforward to use as possible.

## Installation

Add this line to your application's Gemfile:

    gem 'data_smash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install data_smash

## Usage

Using DataSmash is supersimple. You need a convertor and, optionally, a processor e.g.

    class TestConvertor
      include DataSmash::Convertor

      convert ->(item, data) {
        data[:bar] = item[:foo]
        data
      }
    end

    class TestProcessor
      include DataSmash::Processor

      process_with TestConvertor

      smash_in -> {
        [{foo: 'ding'}, {foo: 'dong'}].each {|d| process d }
      }

      smash_out ->(data) {
        # do a thing with your data outputted here
      }
    end

You can just use the convertors on their own, by creating one and calling convert on it with some data e.g.

    convertor = TestConvertor.new
    converted_data = convertor.convert({foo: 'bar'})

And that's it!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
