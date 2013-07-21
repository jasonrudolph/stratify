# Be sure to restart your server when you modify this file.

require 'active_support/inflector'

module ActiveSupport
  # Customize ActiveSupport::Inflector to work around the issue described in
  # https://github.com/rails/rails/pull/9756#discussion_r4954852.
  #
  # Once that issue is resolved, we can remove these customizations and replace
  # them with normal acronym declarations:
  #
  #   ActiveSupport::Inflector.inflections do |inflect|
  #     inflect.acronym 'GitHub'
  #     inflect.acronym 'ITunes'
  #   end
  #
  module Inflector
    # Customize #camelize to handle abnormal capitalizations used by Stratify
    # plugins.
    #
    # Examples
    #
    #   ActiveSupport::Inflector.camelize 'github'
    #   # => "GitHub"
    #
    #   ActiveSupport::Inflector.camelize 'itunes'
    #   # => "ITunes"
    #
    #   ActiveSupport::Inflector.camelize 'stratify/github'
    #   # => "Stratify::GitHub"
    #
    #   ActiveSupport::Inflector.camelize 'stratify/itunes'
    #   # => "Stratify::ITunes"
    #
    def camelize_with_customizations(term, uppercase_first_letter = true)
      term = term.gsub('github', 'git_hub').
                  gsub('itunes', 'i_tunes')

      camelize_without_customizations(term, uppercase_first_letter)
    end
    alias_method :camelize_without_customizations, :camelize
    alias_method :camelize, :camelize_with_customizations

    # Customize #underscore to handle abnormal capitalizations used by Stratify
    # plugins.
    #
    # Examples
    #
    #   ActiveSupport::Inflector.underscore 'GitHub'
    #   # => "github"
    #
    #   ActiveSupport::Inflector.underscore 'ITunes'
    #   # => "itunes"
    #
    #   ActiveSupport::Inflector.underscore 'Stratify::GitHub'
    #   # => "stratify/github"
    #
    #   ActiveSupport::Inflector.underscore 'Stratify::ITunes'
    #   # => "stratify/itunes"
    #
    def underscore_with_customizations(camel_cased_word)
      word = camel_cased_word.gsub('GitHub', 'Github').
                              gsub('ITunes', 'Itunes')
      underscore_without_customizations(word)
    end
    alias_method :underscore_without_customizations, :underscore
    alias_method :underscore, :underscore_with_customizations
  end
end

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
