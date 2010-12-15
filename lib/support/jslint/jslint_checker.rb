
class JSLint
  OK_REASONS = [ "Expected an identifier and instead saw 'undefined' (a reserved word).",
                 "Use '===' to compare with 'null'.",
                 "Use '!==' to compare with 'null'.",
                 "Expected an assignment or function call and instead saw an expression.",
                 "Expected a 'break' statement before 'case'.",
                 "'e' is already defined." ]

  LINT_PATH = File.join(File.dirname(__FILE__), "lint.js")

  def self.lint_file(file)
    begin
      require 'rubygems'
      require 'v8'
    rescue LoadError
      puts "ERROR: Couldn't load therubyracer, which is needed to run JSLint checks. Install via \"gem install therubyracer\", or disable the JS lint checks."
      return []
    end

    errors = []
    V8::Context.new do |context|
      context.load(LINT_PATH)
      context['input'] = lambda{
        File.read(file)
      }

      context['reportErrors'] = lambda{|js_errors|
        js_errors.each do |e|
          next if e.nil? || OK_REASONS.include?(e.reason)

          errors << "\n\e[1;31mJSLINT: #{file}\e[0m"
          errors << "  Error at line #{e['line'].to_i + 1} " + 
            "character #{e['character'].to_i + 1}: \e[1;33m#{e['reason']}\e[0m"
          errors << "#{e['evidence']}"
        end
      }

      context.eval %{
          JSLINT(input(), { evil: true, forin: true, maxerr: 100 });
          reportErrors(JSLINT.errors);
        }
    end

    return errors
  end
end

if __FILE__ == $0
  puts JSLint.lint_file(ARGV[0]).join("\n")
end
