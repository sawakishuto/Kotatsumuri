class OpenAiService
  require "openai"

  def initialize
    @client = OpenAI::Client.new
  end

  def get_response(message)
    begin
      response = @client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [
            { "role": "user", "content": "Please provide the response as a single line without any unnecessary line breaks, extra spaces, or formatting.please tell me #{message} information in japanese only json
            { name: Flower Name,
             description: Description of the flower,
             search_key: first Character of the flower name in hiragana,
             care_periods: [
             {
             start_date: Start date in the format 'MM-DD',
             end_date: End date in the format 'MM-DD',
             period_type: 'blooming_period'
             },
             {
             start_date: Start date in the format 'MM-DD',
             end_date: End date in the format 'MM-DD',
              period_type: 'planting_period'
              },{
              start_date: Start date in the format MM-DD',
              end_date: End date in the format 'MM-DD',
              period_type: 'repotting_period'},
              {
              start_date: Start date in the format 'MM-DD',
              end_date: End date in the format 'MM-DD',
              period_type: 'fertilizing_period'},
              {
              start_date: Start date in the format 'MM-DD',
              end_date: End date in the format 'MM-DD',
              period_type: 'pruning_period'
              }
    ],
    growth_conditions: {light: Light requirements,soil: Soil type,hardiness_zone: Hardiness zone},
    propagation_methods: [{description: Description of propagation method}]}"
  }
          ],
          temperature: 0.0
        }
      )

      if response["choices"]
        decoded_reply = JSON.parse(response["choices"].first["message"]["content"])
        { success: true, reply: decoded_reply }
      else
        { success: false, error: "No response from API" }
      end
    rescue => e
      { success: false, error: e.message }
    end
  end
end
