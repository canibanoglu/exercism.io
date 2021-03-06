class Exercism
  class UnknownLanguage < StandardError; end
end

class Code
  LANGUAGES = {
    'clj' => 'clojure',
    'exs' => 'elixir',
    'erl' => 'erlang',
    'go' => 'go',
    'hs' => 'haskell',
    'java' => 'java',
    'js' => 'javascript',
    'py' => 'python',
    'rb' => 'ruby',
    'rs' => 'rust',
    'm' => 'objective-c',
    'scala' => 'scala',
    'pl' => 'perl5' # Usually .pl for scripts, .pm for modules, .t for test files
  }

  attr_reader :path
  def initialize(path)
    @path = path
  end

  def language
    LANGUAGES.fetch(extension) do
      raise Exercism::UnknownLanguage.new("Cannot determine language of #{filename}")
    end
  end

  def filename
    @filename ||= path_segments.last
  end

  def extension
    @extension ||= filename[/([^\.]+)\Z/, 1]
  end

  def slug
    path_segments[-2]
  end

  private

  def path_segments
    @path_segments = path.gsub("src/main/scala/", "").split(/\/|\\/)
  end
end

