# frozen_string_literal: true

class RichTextConverter
  def self.tags
    {
      "strong": 'b',
      # "u": "u",
      "strikethrough": 's',
      "em": 'i'
    }
  end

  def self.to_unity_text(raw_text)
    formatted_text = raw_text.dup

    tags.each do |html_tag, unity_tag|
      # Replace opening tags
      formatted_text.gsub!(/<#{html_tag}>/, "<#{unity_tag}>")
      # Replace closing tags
      formatted_text.gsub!(%r{</#{html_tag}>}, "</#{unity_tag}>")
    end

    formatted_text.gsub!(/<p>/, '<br>') # Single line break before starting a new paragraph
    formatted_text.gsub!(%r{</p>}, '')

    formatted_text
  end
end
