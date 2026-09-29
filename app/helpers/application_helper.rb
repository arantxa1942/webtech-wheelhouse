module ApplicationHelper
 
  def field_class(record, *attributes, base: "form-control")
    [base, { "is-invalid": field_errors(record, *attributes).any? }]
  end

 
  def field_error(record, *attributes)
    messages = field_errors(record, *attributes)
    tag.div(messages.to_sentence, class: "invalid-feedback") if messages.any?
  end

  private

  def field_errors(record, *attributes)
    attributes.flat_map { |attribute| record.errors[attribute] }
  end
end