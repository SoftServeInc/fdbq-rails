json.call(@feedback, :id, :fields)
json.created_at @feedback.created_at&.iso8601
json.updated_at @feedback.updated_at&.iso8601

if @feedback.errors.present?
  json.errors @feedback.errors.messages
end
