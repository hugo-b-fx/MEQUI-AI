RubyLLM.configure do |config|
  config.provider = :openai
  config.api_key = ENV["OPENAI_API_KEY"]
  config.default_model = "gpt-4o-mini"  # pas cher, ultra rapide, parfait pour le chat
end
