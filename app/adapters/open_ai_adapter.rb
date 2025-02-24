module Adapters
class OpenAiAdapter
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

  def post_diagnoses(params)
    begin

      messages = [
        {
          role: "user",
          content: [
            { type: "text", text: "
            植物の病気を診断したいです。以下の情報をもとに、診断結果をJSON形式で出力してください。**植物情報**
            植物の種類と品種: **#{params[:name]}**
            **栽培環境**
            栽培場所: **#{params[:location]}**
            日照時間: **#{params[:sunlight]}**
            通風状況: **#{params[:ventilation]}**
            土壌の種類: **#{params[:soil_type]}**
            気温と湿度の状況: **#{params[:temperature]}**
            **症状の詳細**
            葉の変色: **#{params[:leaf_color]}**
            茎や根への影響: **#{params[:stem_root_condition]}**
            **水やり・肥料の状況**
            水やり頻度: **#{params[:watering_frequency]}**
            肥料の種類: **#{params[:fertilizer_type]}**
            施肥頻度: **#{params[:fertilizing_frequency]}**
            **農薬・殺虫剤・消毒の使用履歴**
            使用薬剤の有無: **#{params[:pesticide_history]}**
            **季節や天候**
            最近の気候: **#{params[:recent_weather]}**
            ---
            この情報をもとに、病気の診断結果を **以下のJSON形式** で生成してください。(```json` と ``` は不要です)
            {
            disease: <病名>,
            description: <病気の詳細>,
            possible_causes: [
            <原因1>,
            <原因2>,
            <原因3>
            ],
            symptoms: [
            <症状1>,
            <症状2>
            ],
            todo_list: [
            {
            task_id: 1,
            task_name: <対策名>,
            description: <対策の詳細>,
            timing: <実施のタイミング>,
            priority: <優先度: high/medium/low>,
            status: notStarted,
            due_date: <YYYY-MM-DD>
            }
            ],}",
            temperature: 0.0
          },
          { type: "image_url", image_url: { url: params[:image] } } # 画像URLを適切なものに変更
          ]
        }
      ]

      response = @client.chat(
        parameters: {
        model: "gpt-4o-mini",
        messages: messages
    }
      )

      if response["choices"] && response["choices"].first["message"]
        decoded_reply = response["choices"].first["message"]["content"]
        { success: true, reply: decoded_reply }
      else
        { success: false, error: "No response from API" }
      end
    rescue => e
      { success: false, error: e.message }
    end
  end
end
end
