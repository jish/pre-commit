module PreCommit

  def self.pluginator
    Pluginator.find('pre_commit', :extends => [:find_check])
  end

  class PluginsList
    attr_reader :configured_names

    def initialize(configured_names, &block)
      @configured_names = configured_names
      @class_finder     = block
    end

    def evaluated_names
      evaluated_names_(evaluated_names_pairs).flatten
    end

    def list_to_run
      list_to_run_(evaluated_names_pairs).flatten
    end

  private

    def evaluated_names_(list)
      list.map{|name, klass, includes| [name] + evaluated_names_(includes) }
    end

    def list_to_run_(list)
      list.map{|name, klass, includes| [klass] + list_to_run_(includes) }
    end

    def evaluated_names_pairs
      list = find_classes_and_includes(configured_names)
      excludes = excludes(list).flatten.compact
      list = filter_excludes(list, excludes)
      list
    end

    def find_classes_and_includes(list)
      find_classes(list).map{ |name, klass| class_and_includes(name, klass) }
    end

    def find_class(name)
      @class_finder.call(name)
    end

    def find_classes(list)
      list.map{|name| [name, find_class(name)] }.reject{|name, klass| klass.nil? }
    end

    def class_and_includes(name, klass)
      [ name, klass, klass.respond_to?(:includes) ? find_classes_and_includes(klass.includes) : [] ]
    end

    def excludes(list)
      list.map{|name, klass, includes| class_excludes(klass) + excludes(includes) }
    end

    def class_excludes(klass)
      klass.respond_to?(:excludes) ? klass.excludes : []
    end

    def filter_excludes(list, excludes)
      list.map{|name, klass, includes| excludes.include?(name) ? nil : [name, klass, filter_excludes(includes, excludes)] }.compact
    end

  end
end
