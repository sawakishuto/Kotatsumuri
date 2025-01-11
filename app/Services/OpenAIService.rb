class OpenAIService
  require 'openai'

  def initialize
    @client = OpenAI::Client.new
  end

  def get_response(message)
    begin
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: "You are a helpful assistant." },
            { role: "user", content: message }
          ],
          max_tokens: 100,
          temperature: 0.7
        }
      )

      if response["choices"]
        { success: true, reply: response["choices"].first["message"]["content"] }
      else
        { success: false, error: "No response from API" }
      end
    rescue => e
      { success: false, error: e.message }
    end
  end
end
