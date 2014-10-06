require 'pre-commit/line'

module PreCommit
  class ErrorList < Struct.new :errors

    def initialize(errors = [])
      case errors
      when "",nil then errors = []
      when String then errors = [PreCommit::Line.new(errors)]
      end
      super errors
    end

    def to_a
      errors.map(&:to_s)
    end

    def to_s
      to_a.join("\n")
    end

  end
end
