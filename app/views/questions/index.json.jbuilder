json.array!(@questions) do |question|
  json.extract! question, :id, :to, :from, :question, :answer, :answerd?
  json.url question_url(question, format: :json)
end
